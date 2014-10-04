//
//  TabelaArtilharia.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 04/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabelaArtilharia : NSObject{
    NSArray *lista;
    NSArray *cabecalho;
}

@property (nonatomic, retain) NSArray *lista, *cabecalho;

@end
