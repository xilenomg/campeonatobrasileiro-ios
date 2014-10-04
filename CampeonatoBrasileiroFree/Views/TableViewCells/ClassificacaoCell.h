//
//  ClassificacaoCell.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Perez on 6/12/13.
//  Copyright (c) 2013 Dataminas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificacaoCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imageViewTime;

@property (retain, nonatomic) IBOutlet UILabel *lbPontos;
@property (retain, nonatomic) IBOutlet UILabel *lbJogos;
@property (retain, nonatomic) IBOutlet UILabel *lbVitorias;
@property (retain, nonatomic) IBOutlet UILabel *lbEmpate;
@property (retain, nonatomic) IBOutlet UILabel *lbDerrotas;
@property (retain, nonatomic) IBOutlet UILabel *lbPorcentagem;
@property (retain, nonatomic) IBOutlet UILabel *lbPosicao;


@property (retain, nonatomic) IBOutlet UILabel *golsPro;
@property (retain, nonatomic) IBOutlet UILabel *golsContra;
@property (retain, nonatomic) IBOutlet UILabel *saldoGols;

@property (retain, nonatomic) IBOutlet UILabel *lbNome;

@end
