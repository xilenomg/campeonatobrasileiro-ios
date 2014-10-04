//
//  ArtilhariaCell.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Perez on 6/12/13.
//  Copyright (c) 2013 Dataminas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtilhariaCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lbTime;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewTime;

@property (retain, nonatomic) IBOutlet UILabel *lbJogador;

@end
