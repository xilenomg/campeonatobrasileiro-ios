//
//  ClassificacaoController.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 16/04/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuracao.h"
#import "GADInterstitial.h"
#import "GADRequest.h"

@interface ClassificacaoController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GADInterstitialDelegate>{
    IBOutlet UITableView *tabelaClassificacao;
    NSArray *listaTimes;
    
    Configuracao *config;
    
    UIColor *textPosicao, *backgroundPosicao;
    
    AppDelegate *appDelegate;
    
}

@property (nonatomic, retain) NSArray *listaTimes;
@property(nonatomic, strong) GADInterstitial *interstitial;

-(void)atualizaEcriaTela;
@end
