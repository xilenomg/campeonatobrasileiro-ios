//
//  Jogos.h
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/19/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+OSReflectionKit.h"

@interface Jogos : NSObject{
    NSString * sigla_casa;
    NSString * sigla_fora;
    NSString * placar_casa;
    NSString * placar_fora;
    NSString * data_completa;
    NSString * local;
    NSString * time_dns_casa;
    NSString * time_dns_fora;
}

@property(strong, nonatomic) NSString * sigla_casa;
@property(strong, nonatomic) NSString * sigla_fora;
@property(strong, nonatomic) NSString * placar_casa;
@property(strong, nonatomic) NSString * placar_fora;
@property(strong, nonatomic) NSString * data_completa;
@property(strong, nonatomic) NSString * local;
@property(strong, nonatomic) NSString * time_dns_casa;
@property(strong, nonatomic) NSString * time_dns_fora;

-(NSString *) getImageCasaURL;
-(NSString *) getImageForaURL;

@end
