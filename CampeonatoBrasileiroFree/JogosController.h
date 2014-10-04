//
//  JogosController.h
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 17/04/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Jogos.h"
#import "Json.h"
#import "TabelaJogos.h"
#import "Configuracao.h"
#import "GADInterstitial.h"
#import "GADRequest.h"
//#import "GADBannerView.h"


@interface JogosController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GADInterstitialDelegate>{
    IBOutlet UITableView *tabelaJogos;
    IBOutlet UIImageView *backgroundCarregando;

    NSTimer *timer;
    
    Configuracao *config;
    
    TabelaJogos *jogos;
    NSArray *listaJogos;
    NSNumber *rodada;
    
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *atualButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UIView *loadingView;
    
    UIColor *backgroundPar, *backgroundImpar;
    
    int qtdFrames;
    
    NSDate *lastTimeUpdate;
    
    AppDelegate *appDelegate;
    
}

@property (nonatomic, retain) NSArray *listaJogos;

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *atualButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIView *loadingView;
@property(nonatomic, strong) GADInterstitial *interstitial;

-(void) atualizaEcriaTela;
-(void) removeGoalsNotification:(UIImageView *)imagemGolView;
-(void) setLastUpdate;
-(BOOL) shouldShowNewGoals;
- (void)refresh: (NSNumber *) rodadaObj;
-(UIView *) criaGoalNotification: (Time *) timeGol : (int) qtdFrames;
@end
