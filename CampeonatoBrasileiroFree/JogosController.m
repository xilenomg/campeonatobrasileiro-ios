//
//  JogosController.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 17/04/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//
#import "JogosController.h"
#import "JogoCell.h"
#import "JogoHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>




#define REFRESH_HEADER_HEIGHT 260.0f
#define REFRESH_HEADER_LABEL_HEIGHT 52.0f

#define SMALL_FONT_SIZE 9.0
#define MEDIUM_FONT_SIZE 13.0
#define BIG_FONT_SIZE 30.0
#define BIGGEST_FONT_SIZE 50.0

@implementation JogosController

@synthesize listaJogos, backButton, atualButton, nextButton, loadingView;

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *CellIdentifier = @"JogoHeaderCellID";
    JogoHeaderCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    else{
        if ( [listaJogos count] > 0 ){
            if ( ![[[listaJogos objectAtIndex:1] rodada] isEqualToNumber:[NSNumber numberWithInt:0]]){
                headerView.lbRodada.text = [NSString stringWithFormat:@"Rodada %@", [[listaJogos objectAtIndex:1] rodada]];
                headerView.lbRodada.textColor = [UIColor whiteColor];
                rodada = [[listaJogos objectAtIndex:1] rodada];
            }
            else{
                headerView.lbRodada.text = @"-";
            }
        }
        else{
            headerView.lbRodada.text = @"-";
        }
    }
    return headerView;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 26;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"JogoCellID";
    JogoCell *cell = (JogoCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    int row = (int)indexPath.row;
    Jogos *jogo = [listaJogos objectAtIndex: row];
    cell.backgroundColor = [UIColor clearColor];
    
    if ( config.showImages ){
        NSURL *urlCasa = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [[jogo timeCasa] imagem_url] ]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:urlCasa
                              options:0
                             progress:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
         {
             if (image) {
                 [cell.imageViewTimeCasa setImage:image]; // do something with image
             }
         }];
        cell.imageViewTimeCasa.animationDuration = 0.5;

    
        NSURL *urlFora = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [[jogo timeFora] imagem_url] ]];
        [manager downloadImageWithURL:urlFora
                         options:0
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
         {
             if (image) {
                 [cell.imageViewTimeVisitante setImage:image]; // do something with image
             }
         }];
        cell.imageViewTimeVisitante.animationDuration = 0.5;
    }
    
    cell.lbLocalJogo.text = [NSString stringWithFormat:@"Local: %@",[jogo localJogo]];
    cell.lbLocalJogo.textAlignment = NSTextAlignmentCenter;
//    cell.lbLocalJogo.font = [UIFont systemFontOfSize:10];
    
    cell.lbDataJogo.text = [NSString stringWithFormat:@"%@",[jogo dataCompletaJogo]];
    cell.lbDataJogo.textAlignment = NSTextAlignmentCenter;
//    cell.lbDataJogo.font = [UIFont systemFontOfSize:10];
    
    cell.lbPlacarTimeCasa.text = [NSString stringWithFormat:@"%@",[jogo placarCasa]];
    cell.lbPlacarTimeCasa.textAlignment = NSTextAlignmentCenter;
//    cell.lbPlacarTimeCasa.font = [UIFont systemFontOfSize:22];
    
    cell.lbPlacarTimeVisitante.text = [NSString stringWithFormat:@"%@",[jogo placarFora]];
    cell.lbPlacarTimeVisitante.textAlignment = NSTextAlignmentCenter;
//    cell.lbPlacarTimeVisitante.font = [UIFont systemFontOfSize:22];
    
    cell.lbNomeTimeCasa.text = [NSString stringWithFormat:@"%@",[[jogo timeCasa] sigla]];
    cell.lbNomeTimeCasa.textAlignment = NSTextAlignmentCenter;
//    cell.lbNomeTimeCasa.font = [UIFont systemFontOfSize:10];
    
    cell.lbNomeTimeVisitante.text = [NSString stringWithFormat:@"%@",[[jogo timeFora] sigla]];
    cell.lbNomeTimeVisitante.textAlignment = NSTextAlignmentCenter;
//    cell.lbNomeTimeVisitante.font = [UIFont systemFontOfSize:10];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [listaJogos count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Restarting");
    if ( appDelegate.refreshJogos ){
        [self performSelectorInBackground:@selector(refresh:) withObject:rodada];
        appDelegate.refreshJogos = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate loadConfigurations];
    appDelegate.refreshJogos = NO;
    config = [appDelegate config];
    
    tabelaJogos.backgroundColor = [UIColor clearColor];
    
    //admob
    self.interstitial = [self createAndLoadInterstitial];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [tabelaJogos addSubview:refreshControl];
    
    [self setTimer];
    [self startTimer];
    [self performSelectorInBackground:@selector(atualizaEcriaTela) withObject:nil];
}



- (GADInterstitial *)createAndLoadInterstitial {
    //admob
    GADInterstitial *interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = @"ca-app-pub-2766691437061191/2127683060";
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}


- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    if ( [appDelegate reopeningApp] ){
        [self showBanner];
        appDelegate.reopeningApp = NO;
    }
}


-(void) showBanner{
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

-(void) setTimer{
    NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(onTick:)];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sgn];
    [inv setTarget: self];
    [inv setSelector:@selector(onTick:)];
    
    if ( [config.updateInterval intValue] != 0 ) {
        timer = [NSTimer timerWithTimeInterval: ([config.updateInterval intValue] * 60)
                                    invocation: inv 
                                       repeats: YES];
    }
}

-(void)startTimer{
    if ( timer != nil ) {
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer forMode: NSDefaultRunLoopMode];
    }
}

-(void)cancelTimer{
    
}

-(void)onTick:(NSTimer *)timer {
    [self performSelectorInBackground:@selector(refresh:) withObject:rodada];
}

- (IBAction) rodadaAnterior{

    self.navigationItem.leftBarButtonItem.enabled = NO;
    if ( [rodada intValue]  > 1){
        self.loadingView.hidden = NO;
        rodada = [NSNumber numberWithInt:[rodada intValue] -1];
        [self checkButtons];
        [self performSelectorInBackground:@selector(refresh:) withObject:rodada];
    }

}

- (IBAction) rodadaAtual{
    self.loadingView.hidden = NO;
    
    rodada = [NSNumber numberWithInt:0];
    [self checkButtons];
    [self performSelectorInBackground:@selector(refresh:) withObject:rodada];
    

}

- (IBAction) rodadaProxima: (id) sender{


    if ( [rodada intValue] < 38){
        self.loadingView.hidden = NO;
        rodada = [NSNumber numberWithInt:[rodada intValue] + 1];
        [self checkButtons];
        [self performSelectorInBackground:@selector(refresh:) withObject:rodada];
    }
    
}

-(void) checkButtons{
    if ( [rodada intValue] == 1 ) {
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
    else if ( [rodada intValue] == 38 ) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else {
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) refreshAction:(id)sender{
    self.loadingView.hidden = NO;
    [self performSelectorInBackground:@selector(refresh:) withObject: rodada];
    [sender endRefreshing];
}

- (void)refresh: (NSNumber *) rodadaObj{
    
    
    
    if ( [appDelegate reopeningApp] ){
        [self showBanner];
        appDelegate.reopeningApp = NO;
    }
    
    NSArray *anterior = [[listaJogos copy] mutableCopy];
    [listaJogos release];
    jogos = [Json getJogos: rodadaObj];
    listaJogos = jogos.listaJogos;
    [self checkAtualizacao:anterior:listaJogos];
    [anterior release];
    
    if ( listaJogos != nil ){
        [tabelaJogos reloadData];
    }
    else{
        [self checkInternet];
    }
    
    self.loadingView.hidden = YES;

}

-(void)atualizaEcriaTela{
    self.loadingView.hidden = NO;
    [self setLastUpdate];
    tabelaJogos.hidden = YES;

    jogos = [Json getJogos];
    listaJogos = [jogos listaJogos];
    rodada = [jogos rodada];

    [tabelaJogos reloadData];
    
    [self checkButtons];
    [self checkInternet];
    self.loadingView.hidden = YES;
}

-(void) checkAtualizacao:(NSArray *)anterior :(NSArray *)atual{
    
    if ( ![self shouldShowNewGoals] ) {
        return;
    }
    
    int size = (int)[anterior count];
    qtdFrames = 0;
    for (int i = 0; i < size; i++ ){
        Jogos *jogoAnterior = (Jogos *)[anterior objectAtIndex:i];
        Jogos *jogoAtual = (Jogos *)[atual objectAtIndex:i];
        
        if ( jogoAtual.rodada != jogoAnterior.rodada ){
            return;
        }
                               
        if ( jogoAnterior.placarCasa.intValue != jogoAnterior.placarCasa.intValue 
             || jogoAnterior.placarFora.intValue != jogoAtual.placarFora.intValue ) {
            
            Time *timeGol;
            
            NSLog(@"Time Casa: Antes: %d Depois:  %d", jogoAnterior.placarCasa.intValue, jogoAtual.placarCasa.intValue);
            NSLog(@"Time Casa: Antes: %d Depois:  %d", jogoAnterior.placarFora.intValue, jogoAtual.placarFora.intValue);
            
            if ( jogoAnterior.placarCasa.intValue != jogoAtual.placarCasa.intValue ) {
                timeGol = jogoAtual.timeCasa;
                UIView *novoPlacarView = [self criaGoalNotification:timeGol:qtdFrames];
                [self.view addSubview:novoPlacarView];
                [self performSelectorInBackground:@selector(removeGoalsNotification:) withObject:novoPlacarView];
                qtdFrames++;
            }
            
            if ( jogoAnterior.placarFora.intValue != jogoAtual.placarFora.intValue ) {
                timeGol = jogoAtual.timeFora;
                UIView *novoPlacarView = [self criaGoalNotification:timeGol:qtdFrames];
                [self.view addSubview:novoPlacarView];
                [self performSelectorInBackground:@selector(removeGoalsNotification:) withObject:novoPlacarView];
                qtdFrames++;
            }
    
            
            
        }
    }
}

-(UIView *) criaGoalNotification: (Time *) timeGol : (int) qtdFramesTotal{
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    CGRect novoPlacarFrame = CGRectMake((screenWidth - 200) / 2, 5 + ( 36 * qtdFramesTotal), 200, 30);
    UIView *novoPlacarView = [[UIView alloc] initWithFrame:novoPlacarFrame];
    novoPlacarView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
    novoPlacarView.layer.cornerRadius = 5;
    
    CGRect frameImagem = CGRectMake(18, 3, 25, 25);
    UIImageView *imagem = [[UIImageView alloc] initWithFrame:frameImagem];
    imagem.tag = 1;
    [novoPlacarView addSubview:imagem];
    
    CGRect frameGol = CGRectMake(60, 5, 120, 20);
    UIImage *imagemGol = [UIImage imageNamed:@"mensagem_gol"];
    [imagemGol drawInRect:frameGol];
    UIImageView *imagemGolView = [[UIImageView alloc] initWithImage:imagemGol];
    imagemGolView.frame = frameGol;
    imagemGolView.tag = 2;
    [novoPlacarView addSubview:imagemGolView];
    
    
    
    return novoPlacarView;
}

-(void) removeGoalsNotification:(UIView *)novoPlacarView{
    
    [UIView animateWithDuration:1.0
            delay:3 
            options:UIViewAnimationOptionTransitionNone 
            animations:^{novoPlacarView.alpha = 0.0; }
            completion:^(BOOL finished){ [novoPlacarView removeFromSuperview]; }];
    
}

-(void) checkInternet{
    if ( Json.isConnected == NO ){
        UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"Sem conexão" 
                                                         message:@"Você não está conectado a internet!"
                                                        delegate:self 
                                               cancelButtonTitle:@"Fechar" 
                                               otherButtonTitles:nil, 
                              nil];
        [alert show];
        
    }
    
    tabelaJogos.hidden = NO;

}

- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
    }
    else
    {
       
    }
}

-(BOOL)shouldShowNewGoals{
    NSDate *now = [[NSDate date] retain];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:lastTimeUpdate];
    
    int maxSeconds = 600; //5 minutos
    
    int numberOfSeconds = secondsBetween;
    
    [self setLastUpdate];
    
    if ( numberOfSeconds > maxSeconds ){
        return NO;
    }
    return YES;

}
-(void)setLastUpdate{
    lastTimeUpdate = [[NSDate date] retain];
}
@end
