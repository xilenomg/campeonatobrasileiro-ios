//
//  AppDelegate.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 8/10/13.
//  Copyright (c) 2013 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "AppDelegate.h"
#import "Json.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize config, refreshJogos, reopeningApp;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

-(id)config{
    return config;
}

-(void)loadConfigurations{
    config = [[Configuracao alloc] init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    config = [[Configuracao alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]);
    NSLog(@"application");
    self.reopeningApp = YES;
    [self registerNotifications:application];
//    
//    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;
}

- (void) registerNotifications:(UIApplication *)application{
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
    [Json signupDevice:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    NSLog(@"applicationDidEnterBackground");
    refreshJogos = YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    NSLog(@"applicationWillEnterForeground");
    self.reopeningApp = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    NSLog(@"applicationDidBecomeActive");
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    NSLog(@"applicationWillTerminate");
}

@end
