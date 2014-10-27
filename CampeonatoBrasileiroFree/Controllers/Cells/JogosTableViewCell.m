//
//  JogosTableViewCell.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/18/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "JogosTableViewCell.h"

@implementation JogosTableViewCell

@synthesize timeCasa,timeFora, siglaCasa,siglaFora,placarCasa,placarFora, jogoData,jogoLocal;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
