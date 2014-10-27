//
//  Jogos.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/19/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "Jogos.h"
#import "Constants.h"

@implementation Jogos

@synthesize sigla_casa, sigla_fora, placar_casa, placar_fora, data_completa, local, time_dns_casa, time_dns_fora;

-(NSString *) getImageCasaURL{
    return [NSString stringWithFormat: URL_TIME_IMAGEM, self.time_dns_casa];
}

-(NSString *) getImageForaURL{
    return [NSString stringWithFormat: URL_TIME_IMAGEM, self.time_dns_fora];
}

@end
