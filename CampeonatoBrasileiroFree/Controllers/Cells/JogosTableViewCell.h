//
//  JogosTableViewCell.h
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/18/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JogosTableViewCell : UITableViewCell{
    IBOutlet UIImageView * timeCasa;
    IBOutlet UIImageView * timeFora;
    IBOutlet UILabel * siglaCasa;
    IBOutlet UILabel * siglaFora;
    IBOutlet UILabel * placarCasa;
    IBOutlet UILabel * placarFora;
    IBOutlet UILabel * jogoData;
    IBOutlet UILabel * jogoLocal;
}

@property (strong, nonatomic) IBOutlet UIImageView * timeCasa;
@property (strong, nonatomic) IBOutlet UIImageView * timeFora;
@property (strong, nonatomic) IBOutlet UILabel * siglaCasa;
@property (strong, nonatomic) IBOutlet UILabel * siglaFora;
@property (strong, nonatomic) IBOutlet UILabel * placarCasa;
@property (strong, nonatomic) IBOutlet UILabel * placarFora;
@property (strong, nonatomic) IBOutlet UILabel * jogoData;
@property (strong, nonatomic) IBOutlet UILabel * jogoLocal;


@end
