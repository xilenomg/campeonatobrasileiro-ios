//
//  AppDelegate.h
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 8/10/13.
//  Copyright (c) 2013 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuracao.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    Configuracao *config;
    BOOL refreshJogos;
    BOOL reopeningApp;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Configuracao *config;
@property (nonatomic) BOOL refreshJogos;
@property (nonatomic) BOOL reopeningApp;

-(id)config;
-(void)loadConfigurations;
@end
