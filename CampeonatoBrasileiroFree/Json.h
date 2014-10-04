//
//  Json.h
//  Easy Lyrics
//
//  Created by Luis Felipe Correa Perez on 05/02/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabelaJogos.h"
#import "Jogos.h"
#import "Artilheiro.h"
#import "TabelaArtilharia.h"

@interface Json : NSObject{
    NSString *url;
    BOOL isConnected;
}

@property (nonatomic, retain) NSString *url;

-(NSInputStream *) run;
-(NSString *) encodeString:(NSStringEncoding) encoding;

+(BOOL)isConnected;
+ (void)setIsConnected:(BOOL)newIsConnected;



+(TabelaJogos *)getJogos;
+(TabelaJogos *)getJogos:(NSNumber *) rodada;
+(NSArray *)getClassificacao;
+(TabelaArtilharia *)getArtilheiros;
+ (void) signupDevice: (NSString *) token;

@end
