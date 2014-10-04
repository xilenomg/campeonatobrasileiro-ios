//
//  Time.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 12/06/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import "Time.h"

@implementation Time

@synthesize nome, sigla, imagem_url, pontos, jogos, vitorias, empates, derrotas, aproveitamento, posicao;

-(NSString *)toString{
    return [NSString stringWithFormat:@"%@ - %@", nome, sigla];
}

@end