//
//  Time.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 12/06/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject{
    NSString *nome, *sigla, *imagem_url;
    NSNumber *pontos, *jogos, *vitorias, *empates, *derrotas, *aproveitamento, *posicao;
}

@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *sigla;
@property (nonatomic, retain) NSNumber *posicao;
@property (nonatomic, retain) NSString *imagem_url;
@property (nonatomic, retain) NSNumber *pontos;
@property (nonatomic, retain) NSNumber *jogos;
@property (nonatomic, retain) NSNumber *vitorias;
@property (nonatomic, retain) NSNumber *empates;
@property (nonatomic, retain) NSNumber *derrotas;
@property (nonatomic, retain) NSNumber *aproveitamento;

@property (nonatomic, retain) NSNumber *golsPro;
@property (nonatomic, retain) NSNumber *golsContra;
@property (nonatomic, retain) NSNumber *saldoGols;

-(NSString *)toString;

@end