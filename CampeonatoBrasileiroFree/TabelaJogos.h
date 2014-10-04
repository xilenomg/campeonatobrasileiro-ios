//
//  TabelaJogos.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 12/06/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabelaJogos : NSObject{
    NSArray *listaJogos;
    NSNumber *rodada;
}

@property (nonatomic, retain) NSArray *listaJogos;
@property (nonatomic, retain) NSNumber *rodada;

@end
