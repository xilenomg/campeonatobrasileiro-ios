//
//  Artilheiro.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 03/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artilheiro : NSObject{
    NSString *nomeJogador;
    NSNumber *gols;
    NSString *siglaTime;
    NSString *dnsTime;
    NSString *imagemUrl;
}

@property (nonatomic, retain) NSString *nomeJogador, *siglaTime, *dnsTime, *imagemUrl;
@property (nonatomic, retain) NSNumber *gols;


@end
