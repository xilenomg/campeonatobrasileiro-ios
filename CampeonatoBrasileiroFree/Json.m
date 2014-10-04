//
//  Json.m
//  Easy Lyrics
//
//  Created by Luis Felipe Correa Perez on 05/02/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import "Json.h"

#define LINK_JOGOS @"http://campeonatobrasileiro.dataminas.com.br/iphone/jogos.php"
#define LINK_CLASS @"http://campeonatobrasileiro.dataminas.com.br/iphone/classificacao.php"
#define LINK_ARTIL @"http://campeonatobrasileiro.dataminas.com.br/iphone/artilharia.php"
#define LINK_PUSHN @"http://campeonatobrasileiro.dataminas.com.br/iphone/pushnotification.php"
#define URL_IMAGEM @"http://campeonatobrasileiro.dataminas.com.br/_imagens/times/"

static BOOL isConnected;

@implementation Json

@synthesize url;

+(BOOL)isConnected{
    return isConnected;
}

+ (void)setIsConnected:(BOOL)newIsConnected {
        isConnected = newIsConnected;
}


-(void)dealloc{
    [url release];
    [super release];
    [super dealloc];
}

-(NSInputStream *)run{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *collection = [[NSData dataWithContentsOfURL:[NSURL URLWithString:[self url]]] retain];
    if ( collection ) {
    
        NSInputStream *stream = [[[NSInputStream alloc] initWithData:collection] autorelease];
        [collection release];
        return stream;
    }
    
    return nil; 
}

- (NSString *)encodeString:(NSStringEncoding)encoding{
    CFStringRef encodingObject = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                            NULL, (CFStringRef)@";/?:@&=$+{}<>,",
                                            CFStringConvertNSStringEncodingToEncoding(encoding));
    NSString *encodedString = (NSString *) encodingObject ;
    CFRelease(encodedString);
    return encodedString;
} 

+(TabelaJogos *)getJogos{
    return [self getJogos: [NSNumber numberWithInt:0]];
}

+ (void) signupDevice: (NSString *) token{
    NSString *url = [NSString stringWithFormat: @"%@?device=ios&token=%@", LINK_PUSHN, token];

    NSLog(@"URL: %@", url);
    
    Json *json = [[Json alloc] init];
    json.url = url;
    NSInputStream *jogosStream = [json run];
    if ( jogosStream != nil ) {
        [jogosStream open];
        NSError *parseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:jogosStream options:NSJSONReadingAllowFragments error:&parseError];
        NSLog(@"%@", jsonObject);
        [jogosStream close];
    }
}

+(TabelaJogos *)getJogos:(NSNumber *) rodadaDesejada{
    NSString *url;
    NSNumber *rodadaNameDiff = [NSNumber numberWithInt:0];
   
    rodadaNameDiff = rodadaDesejada;

    
    if ( [rodadaNameDiff intValue] != 0 ) {
        url = [NSString stringWithFormat: @"%@?rodada=%@", LINK_JOGOS, rodadaNameDiff];
    }
    else{
        url = LINK_JOGOS;
    }
    
    NSLog(@"URL: %@", url);
    
    Json *json = [[Json alloc] init]; 
    json.url = url;
    NSInputStream *jogosStream = [json run];
    
    
    if ( jogosStream != nil ) {
        [jogosStream open];
        
        NSMutableArray *listaJogos;
        
        NSError *parseError = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:jogosStream options:NSJSONReadingAllowFragments error:&parseError];    
        
        if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
            
            int count = (int)[jsonObject count];
            listaJogos = [[NSMutableArray alloc] initWithCapacity:count];
            
            rodadaDesejada = [NSNumber numberWithInt: [[jsonObject objectForKey:@"rodada_lida"] intValue]];
            
            for (NSDictionary *jogo in [jsonObject objectForKey:@"jogos"]) {
                Jogos *jogoObj = [[Jogos alloc] init];
                
                Time *timeCasa = [[Time alloc] init];
                timeCasa.nome = [jogo objectForKey:@"time_casa"];
                timeCasa.sigla = [jogo objectForKey:@"sigla_casa"];
                timeCasa.imagem_url = [NSString stringWithFormat:@"%@%@.png", URL_IMAGEM,[jogo objectForKey:@"time_dns_casa"]];
                
                Time *timeFora = [[Time alloc] init];
                timeFora.nome = [jogo objectForKey:@"time_fora"];
                timeFora.sigla = [jogo objectForKey:@"sigla_fora"];
                timeFora.imagem_url = [NSString stringWithFormat:@"%@%@.png", URL_IMAGEM,[jogo objectForKey:@"time_dns_fora"]];
                
                jogoObj.timeCasa = timeCasa;
                jogoObj.timeFora = timeFora;
                
                jogoObj.placarCasa = [jogo objectForKey:@"placar_casa"];
                jogoObj.placarFora = [jogo objectForKey:@"placar_fora"];
                
                jogoObj.localJogo = [jogo objectForKey:@"local"];
                
                jogoObj.dataCompletaJogo = [[jogo objectForKey:@"data_completa"] uppercaseString];
                
                jogoObj.rodada = [NSNumber numberWithInt: [rodadaDesejada intValue]];
                
                [listaJogos addObject: jogoObj];
//                NSLog(@"Jogo %@ x %@", [[jogoObj timeCasa] nome], [[jogoObj timeFora] nome]);
            }
            
        }
        else{
            
            NSLog(@"%@",[NSString stringWithFormat:@"Verifique o JSON: %@", jsonObject]);
            
        }
        
        [jogosStream close];
        TabelaJogos *tabela = [[TabelaJogos alloc] init];
        tabela.rodada = rodadaDesejada;
        tabela.listaJogos = listaJogos;
        [self setIsConnected:YES];
        return tabela;
    }
    else{
        [self setIsConnected:NO];
    }
    return nil; 
}

+(NSArray *)getClassificacao{
    NSString *url= LINK_CLASS;
    
    Json *json = [[Json alloc] init]; 
    json.url = url;
    [url release];
    NSInputStream *classificacaoStream = [json run];

    if ( classificacaoStream != nil ) {
        [classificacaoStream open];
        
        NSMutableArray *listaTimes = nil;
        
        NSError *parseError = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:classificacaoStream options:NSJSONReadingAllowFragments error:&parseError];    
        
        if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
            
            int count = (int)[jsonObject count];

            listaTimes = [[NSMutableArray alloc] initWithCapacity:count];
            
            for (NSDictionary *timeJson in [jsonObject objectForKey:@"classificacao"]) {
                
                Time *time = [[Time alloc] init];
                time.nome = [timeJson objectForKey:@"nome"];
                time.posicao = [timeJson objectForKey:@"posicao"];
                time.sigla = [timeJson objectForKey:@"sigla"];
                time.jogos = [timeJson objectForKey:@"jogos"];
                time.pontos = [timeJson objectForKey:@"pontos"];
                time.vitorias = [timeJson objectForKey:@"vitorias"];
                time.empates = [timeJson objectForKey:@"empate"];
                time.derrotas = [timeJson objectForKey:@"derrotas"];
                time.aproveitamento = [timeJson objectForKey:@"aproveitamento"];
                
                
                time.golsPro = [timeJson objectForKey:@"gols_pro"];
                time.golsContra = [timeJson objectForKey:@"gols_contra"];
                time.saldoGols = [timeJson objectForKey:@"saldo_gols"];
                
                time.imagem_url = [NSString stringWithFormat:@"%@%@.png", URL_IMAGEM,[timeJson objectForKey:@"dns"]];
                
//                NSLog(@"%@ adicionado a tabela", time.nome);
                
                [listaTimes addObject: time];
                [time release];
            }

        }
        else{
            
            NSLog(@"%@",[NSString stringWithFormat:@"Verifique o JSON: %@", jsonObject]);
            
        }
        
        [classificacaoStream close];
        [self setIsConnected:YES];
        [json release];
        return listaTimes;
    }
    else{
        [self setIsConnected:NO];
    }
    [json release];
    return nil; 
}

+(TabelaArtilharia *)getArtilheiros{
    NSString *url= LINK_ARTIL;
    
    Json *json = [[Json alloc] init]; 
    json.url = url;
    [url release];
    NSInputStream *artilhariaStream = [json run];
    [json release];
    
    if ( artilhariaStream != nil ) {
        [artilhariaStream open];
        
        NSMutableArray *listaArtilheiros = nil;
        NSMutableArray *cabecalhoArtilheiros = [[[NSMutableArray alloc] init] autorelease];
        NSNumber *golAux = [NSNumber numberWithInt:-1 ];
        
        NSError *parseError = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:artilhariaStream options:NSJSONReadingAllowFragments error:&parseError];    
        
//        NSLog(@"%a",[NSString stringWithFormat:@"Verifique o JSON: %@", jsonObject]); 
        
        if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
            
            int count = (int)[jsonObject count];
            listaArtilheiros = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];
            
            for (NSDictionary *timeJson in [jsonObject objectForKey:@"artilharia"]) {
                
                Artilheiro *artilheiro = [[Artilheiro alloc] init];
                artilheiro.nomeJogador = [timeJson objectForKey:@"nome_jogador"];
                artilheiro.gols = [timeJson objectForKey:@"gols"];
                artilheiro.siglaTime = [timeJson objectForKey:@"sigla_time"];
                artilheiro.dnsTime = [timeJson objectForKey:@"time_dns"];
                artilheiro.imagemUrl = [NSString stringWithFormat:@"%@%@.png", URL_IMAGEM,[timeJson objectForKey:@"time_dns"]];
                
                if ( [artilheiro.gols intValue] != [golAux intValue] ) {
                    golAux = artilheiro.gols;
                    [cabecalhoArtilheiros addObject:golAux];
                }
                
                [listaArtilheiros addObject: artilheiro];
//                NSLog(@"Jogador %@ com %@ gols",artilheiro.nomeJogador, artilheiro.gols);
                [artilheiro release];
            }
        }
        else{
            
//            NSLog(@"%a",[NSString stringWithFormat:@"Verifique o JSON: %@", jsonObject]);
            
        }
        
        [artilhariaStream close];
        TabelaArtilharia *tabelaArtilharia = [[[TabelaArtilharia alloc] init] autorelease];
        [tabelaArtilharia setLista:listaArtilheiros];
        [tabelaArtilharia setCabecalho:cabecalhoArtilheiros];
        [self setIsConnected:YES];
        return tabelaArtilharia;
    }
    else{
        [self setIsConnected:NO];
    }
    return nil; 
}




@end
