//
//  ViewController.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/12/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "ViewController.h"
#import "MMDrawerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"DRAWER_SEGUE" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DRAWER_SEGUE"]) {
        MMDrawerController *destinationViewController = (MMDrawerController *) segue.destinationViewController;
        
        // Instantitate and set the center view controller.
        UIViewController *centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"JOGOS_TOP_VIEW_CONTROLLER"];
        [destinationViewController setCenterViewController:centerViewController];
        
        // Instantiate and set the left drawer controller.
        UIViewController *leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDE_DRAWER_CONTROLLER"];
        [destinationViewController setLeftDrawerViewController:leftDrawerViewController];
        
        // Instantiate and set the left drawer controller.
        UIViewController *rightDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RODADA_DRAWER_CONTROLLER"];
        [destinationViewController setRightDrawerViewController:rightDrawerViewController];
        
    }
}

@end
