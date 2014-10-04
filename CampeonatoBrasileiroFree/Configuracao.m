//
//  Configuracao.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 18/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import "Configuracao.h"

@implementation Configuracao

@synthesize showImages, updateInterval, version;

- (id)init {
    [self loadConfiguration];
    NSLog(@"Propriedades\nshow images: %d\nupdate Interval: %@\n\n",[self showImages], [self updateInterval]);
    return self;
}

-(void)loadConfiguration{
    [self readConfigurationFile];
    [self setProperty];
}

-(void)readConfigurationFile{
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        [self setDefaultValues];
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
}

-(void)setProperty{
    showImages = [[NSUserDefaults standardUserDefaults] boolForKey:@"show_images"];
    updateInterval = [[NSUserDefaults standardUserDefaults] valueForKey:@"update_interval"];
    version =  (NSString *) [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ( version != nil ) {
        [[NSUserDefaults standardUserDefaults] setObject: version forKey:@"versao"];
        [[NSUserDefaults standardUserDefaults] synchronize]; 
    }
}

-(void)setDefaultValues{
    updateInterval = [[NSNumber alloc] initWithInt:1];
    showImages = YES;
}

@end
