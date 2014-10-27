//
//  MenuViewController.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/17/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface MenuViewController ()
    @property(nonatomic) int currentIndex;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Buttons Click
- (IBAction)clickButton:(id)sender{
    UIButton *button = (UIButton *) sender;
    
    if (self.currentIndex == button.tag) {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        return;
    }
    
    UIViewController *centerViewController;
    switch(button.tag){
        case 1:
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"JOGOS_TOP_VIEW_CONTROLLER"];
            break;
        case 2:
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CLASSIFICACAO_TOP_VIEW_CONTROLLER"];
            break;
        case 3:
            centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ARTILHARIA_TOP_VIEW_CONTROLLER"];
            break;
            
        default: break;
    }
    
    if (centerViewController) {
        self.currentIndex = button.tag;
        [self.mm_drawerController setCenterViewController:centerViewController withCloseAnimation:YES completion:nil];
    } else {
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}
@end
