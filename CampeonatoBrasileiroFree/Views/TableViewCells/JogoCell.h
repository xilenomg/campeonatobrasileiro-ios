//
//  JogoCell.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Perez on 6/12/13.
//  Copyright (c) 2013 Dataminas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JogoCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lbNomeTimeCasa;
@property (retain, nonatomic) IBOutlet UILabel *lbNomeTimeVisitante;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewTimeCasa;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewTimeVisitante;
@property (retain, nonatomic) IBOutlet UILabel *lbPlacarTimeCasa;
@property (retain, nonatomic) IBOutlet UILabel *lbPlacarTimeVisitante;
@property (retain, nonatomic) IBOutlet UILabel *lbLocalJogo;
@property (retain, nonatomic) IBOutlet UILabel *lbDataJogo;

@end
