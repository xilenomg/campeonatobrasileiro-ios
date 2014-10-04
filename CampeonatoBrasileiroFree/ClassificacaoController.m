//
//  ClassificacaoController.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 16/04/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ClassificacaoController.h"
#import "Json.h"
#import "Time.h"
#import "ClassificacaoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>



#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad


@implementation ClassificacaoController

@synthesize listaTimes;

#define REFRESH_HEADER_HEIGHT 260.0f
#define REFRESH_HEADER_LABEL_HEIGHT 52.0f
#define SMALL_FONT_SIZE 9.0
#define MEDIUM_FONT_SIZE 13.0
#define BIG_FONT_SIZE 30.0
#define BIGGEST_FONT_SIZE 50.0

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *CellIdentifier = @"ClassificacaoHeaderCellID";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return headerView;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 26;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *MyIdentifier = @"ClassificacaoCellID";
    ClassificacaoCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    int row = (int)indexPath.row;
    Time *time = [listaTimes objectAtIndex: row];
    
    
    if ( config.showImages ){
        NSURL *urlCasa = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [time imagem_url] ]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:urlCasa
                              options:0
                             progress:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
         {
             if (image) {
                 [cell.imageViewTime setImage:image];
             }
         }];
    }
    cell.lbNome.text = [NSString stringWithFormat:@"%@",[time sigla]];
    cell.lbNome.textAlignment = NSTextAlignmentCenter;
    
    cell.lbPontos.text = [NSString stringWithFormat:@"%@",[time pontos]];
    cell.lbPontos.textAlignment = NSTextAlignmentCenter;
    
    cell.lbJogos.text = [NSString stringWithFormat:@"%@",[time jogos]];
    cell.lbJogos.textAlignment = NSTextAlignmentCenter;
    
    cell.lbVitorias.text = [NSString stringWithFormat:@"%@",[time vitorias]];
    cell.lbVitorias.textAlignment = NSTextAlignmentCenter;
    
    cell.lbEmpate.text = [NSString stringWithFormat:@"%@",[time empates]];
    cell.lbEmpate.textAlignment = NSTextAlignmentCenter;
    
    cell.lbDerrotas.text = [NSString stringWithFormat:@"%@",[time derrotas]];
    cell.lbDerrotas.textAlignment = NSTextAlignmentCenter;
    
    cell.lbPorcentagem.text = [NSString stringWithFormat:@"%@",[time aproveitamento]];
    cell.lbPorcentagem.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
    cell.golsPro.text = [NSString stringWithFormat:@"%@",[time golsPro]];
    cell.golsPro.textAlignment = NSTextAlignmentCenter;
    
    cell.golsContra.text = [NSString stringWithFormat:@"%@",[time golsContra]];
    cell.golsContra.textAlignment = NSTextAlignmentCenter;
    
    cell.saldoGols.text = [NSString stringWithFormat:@"%@",[time saldoGols]];
    cell.saldoGols.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    cell.lbPosicao.text = [NSString stringWithFormat:@"%@", [[[NSNumber alloc] initWithInt:(((int)indexPath.row)+1)]autorelease]];
    cell.lbPosicao.textAlignment = NSTextAlignmentCenter;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (IDIOM == IPAD ){
//    return 89;
//    }
//    return 50;
//}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [listaTimes count];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    config = [appDelegate config];
    //admob
    self.interstitial = [self createAndLoadInterstitial];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [tabelaClassificacao addSubview:refreshControl];
    tabelaClassificacao.backgroundColor = [UIColor clearColor];
    
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
    [self performSelectorInBackground:@selector(refresh) withObject:nil];
    [sender endRefreshing];
}

- (void)refresh {
    if ( [appDelegate reopeningApp] ){
        [self showBanner];
        appDelegate.reopeningApp = NO;
    }
        
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    listaTimes = [Json getClassificacao];
    if ( listaTimes != nil ) {
        [tabelaClassificacao reloadData];
    }
    else{
        [self checkInternet];
    }
}
-(void) showBanner{
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

-(void)atualizaEcriaTela{

    tabelaClassificacao.hidden = YES;
    
    listaTimes = [Json getClassificacao];
    
    [tabelaClassificacao performSelectorInBackground:@selector(reloadData) withObject:nil];

    [self checkInternet];
    
    
    
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
    
    tabelaClassificacao.hidden = NO;
}
@end
