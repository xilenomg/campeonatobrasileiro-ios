//
//  CustomNavigationBar.m
//  Easy Lyrics
//
//  Created by Luis Felipe Correa Perez on 04/02/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

-(void)drawRect:(CGRect)rect{
    
    UIImage *imageBackground = [UIImage imageNamed: @"NavigationBar.png"];
    [imageBackground drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    UIImage *imageLogo = [UIImage imageNamed: @"logomarca.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageLogo];
   
    imageView.frame = CGRectMake(60, 12, 200, 21);
    
    self.topItem.titleView = imageView;
    [imageView release];
    
}



@end
