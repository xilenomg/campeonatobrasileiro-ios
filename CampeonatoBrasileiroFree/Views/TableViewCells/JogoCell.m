//
//  JogoCell.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Perez on 6/12/13.
//  Copyright (c) 2013 Dataminas. All rights reserved.
//

#import "JogoCell.h"

@implementation JogoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lbNomeTimeCasa release];
    [_lbNomeTimeVisitante release];
    [_imageViewTimeVisitante release];
    [_imageViewTimeCasa release];
    [_imageViewTimeVisitante release];
    [_lbPlacarTimeCasa release];
    [_lbPlacarTimeVisitante release];
    [_lbLocalJogo release];
    [_lbDataJogo release];
    [super dealloc];
}
@end
