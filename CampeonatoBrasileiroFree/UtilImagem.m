//
//  UtilImagem.m
//  Easy Lyrics
//
//  Created by Luis Felipe Correa Perez on 08/02/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import "UtilImagem.h"

@implementation UtilImagem

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}


@end
