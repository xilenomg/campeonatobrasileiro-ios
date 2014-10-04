//
//  Jogos.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 12/06/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Jogos : NSObject{
    Time *timeCasa, *timeFora;
    NSNumber *placarCasa, *placarFora;
    NSNumber *rodada;
    NSString *localJogo;
    NSDate *dataJogo;
    NSString *dataCompletaJogo;
}

@property (nonatomic, retain) Time *timeCasa, *timeFora;
@property (nonatomic, retain) NSString *localJogo, *dataCompletaJogo;
@property (nonatomic, retain) NSDate *dataJogo;
@property (nonatomic, retain) NSNumber *placarCasa, *placarFora;
@property (nonatomic, retain) NSNumber *rodada;

@end
