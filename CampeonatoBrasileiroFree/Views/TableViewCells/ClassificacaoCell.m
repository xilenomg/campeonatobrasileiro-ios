//
//  ClassificacaoCell.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Perez on 6/12/13.
//  Copyright (c) 2013 Dataminas. All rights reserved.
//

#import "ClassificacaoCell.h"

@implementation ClassificacaoCell

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
    [_imageViewTime release];
    [_lbPontos release];
    [_lbJogos release];
    [_lbVitorias release];
    [_lbEmpate release];
    [_lbDerrotas release];
    [_lbPorcentagem release];
    [_imageViewTime release];
    [_lbPosicao release];
    [_lbNome release];
    [super dealloc];
}
@end
