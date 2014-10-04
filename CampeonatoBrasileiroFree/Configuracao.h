//
//  Configuracao.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 18/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuracao : NSObject{
    NSNumber *updateInterval;
    BOOL showImages;
    NSString *version;
}

@property(nonatomic, retain) NSNumber *updateInterval;
@property(nonatomic) BOOL showImages;
@property(nonatomic, retain) NSString *version;

-(void)readConfigurationFile;

@end
