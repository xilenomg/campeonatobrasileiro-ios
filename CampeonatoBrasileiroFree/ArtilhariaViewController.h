//
//  ArtilhariaViewController.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 03/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuracao.h"
#import "GADInterstitial.h"
#import "GADRequest.h"

@interface ArtilhariaViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GADInterstitialDelegate>{
    
    IBOutlet UITableView *tabelaArtilheiros;
    NSArray *listaArtilheiros;
    NSArray *cabecalhoArtilheiros;
    
    Configuracao *config;
    
    AppDelegate *appDelegate;
}

@property (nonatomic, retain) NSArray *listaArtilheiros;
@property(nonatomic, strong) GADInterstitial *interstitial;

-(void)atualizaEcriaTela;
-(NSMutableArray *) getElementosByGols:(NSNumber *) gols;

@end
