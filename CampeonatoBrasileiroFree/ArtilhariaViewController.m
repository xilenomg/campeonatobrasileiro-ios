//
//  ArtilhariaViewController.m
//  Campeonato Brasileiro
//
//  Created by Luis Felipe Correa Perez on 03/07/12.
//  Copyright (c) 2012 Dataminas. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ArtilhariaViewController.h"
#import "Json.h"
#import "Artilheiro.h"
#import "ArtilhariaCell.h"
#import "ArtilhariaHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArtilhariaViewController

#define REFRESH_HEADER_HEIGHT 260.0f
#define REFRESH_HEADER_LABEL_HEIGHT 52.0f
#define SMALL_FONT_SIZE 9.0
#define MEDIUM_FONT_SIZE 13.0
#define BIG_FONT_SIZE 16.0
#define BIGGEST_FONT_SIZE 40.0

@synthesize listaArtilheiros;

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 26;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *CellIdentifier = @"ArtilhariaHeaderCellID";
    ArtilhariaHeaderCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *plural = [[cabecalhoArtilheiros objectAtIndex:section] intValue] == 1 ? @"" : @"s";
    headerView.lbHeader.text = [NSString stringWithFormat:@"Jogadores com %@ gol%@", [cabecalhoArtilheiros objectAtIndex:section], plural];
    
    headerView.lbHeader.font = [UIFont systemFontOfSize:14];
    headerView.lbHeader.textColor = [UIColor whiteColor];

    
    
    return headerView;
}

int sectionAux = 0;
NSArray *listaArtilheirosAux;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *MyIdentifier = @"ArtilhariaCellID";
    ArtilhariaCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    int section = (int)indexPath.section;
    if ( [[cabecalhoArtilheiros objectAtIndex:section] intValue] !=  sectionAux ){
        listaArtilheirosAux = [self getElementosByGols:[cabecalhoArtilheiros objectAtIndex:section]];
    }
    
    int row = (int) indexPath.row;
    
    Artilheiro *artilheiro = [listaArtilheirosAux objectAtIndex: row];

    if ( config.showImages ){
        NSURL *urlCasa = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [artilheiro imagemUrl ]]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:urlCasa
                              options:0
                             progress:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
         {
             if (image) {
                 [cell.imageViewTime setImage:image]; // do something with image
             }
         }];
        
//        [cell.imageViewTime loadURL:urlCasa animated:YES withCredential:nil name:[NSString stringWithFormat:@"%@",[artilheiro siglaTime]]];
//        cell.imageViewTime.animationDuration = 0.5;
//        cell.imageViewTime.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    
    cell.lbTime.text = [NSString stringWithFormat:@"%@",[artilheiro siglaTime]];
    cell.lbTime.font = [UIFont systemFontOfSize:10];
    
    cell.lbJogador.text = [NSString stringWithFormat:@"%@",[artilheiro nomeJogador]];
    cell.lbJogador.font = [UIFont systemFontOfSize:14];
    
    //gols.text = [NSString stringWithFormat:@"%@",[artilheiro gols]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)t heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    NSInteger rows = [self getSectionLength:[cabecalhoArtilheiros objectAtIndex: section]];
	return rows;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return [cabecalhoArtilheiros count];
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
    [tabelaArtilheiros addSubview:refreshControl];
    tabelaArtilheiros.backgroundColor = [UIColor clearColor];
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

#pragma mark - Loading

-(IBAction) refreshAction:(id)sender{
    [self performSelectorInBackground:@selector(refresh) withObject:nil];
    [sender endRefreshing];
}

- (void)refresh {
    
    
    if ( [appDelegate reopeningApp] ){
        [self showBanner];
        appDelegate.reopeningApp = NO;
    }
    
    TabelaArtilharia *tabelaArtilharia = [Json getArtilheiros];
    listaArtilheiros = tabelaArtilharia.lista;
    cabecalhoArtilheiros = tabelaArtilharia.cabecalho;
    
    if ( listaArtilheiros != nil ) {
        [tabelaArtilheiros reloadData];
    }
    else{
        [self checkInternet];
    }
    sectionAux = 0;
}

-(NSInteger) getSectionLength:(NSNumber *) gols{
    NSInteger count = 0 ;
    for ( int i = 0; i < [listaArtilheiros count] ; i++ ){
        if ( [gols intValue] == [[[listaArtilheiros objectAtIndex:i] gols] intValue] ){
            count++;
        }
    }
    
    return count;
}

-(NSMutableArray *) getElementosByGols:(NSNumber *) gols{
    if ( [listaArtilheiros count] > 0 ){
        NSMutableArray *artilheiros = [[[NSMutableArray alloc] init] autorelease];
        for ( int i = 0; i < [listaArtilheiros count] ; i++ ){
            if ( [gols intValue] == [[[listaArtilheiros objectAtIndex:i] gols] intValue] ){
                [artilheiros addObject:[listaArtilheiros objectAtIndex:i]];
            }
        }
        
        return artilheiros;
    }
    return nil;
}

-(void)atualizaEcriaTela{
    tabelaArtilheiros.hidden = YES;
    TabelaArtilharia *tabelaArtilharia = [Json getArtilheiros];
    listaArtilheiros = tabelaArtilharia.lista;
    cabecalhoArtilheiros = tabelaArtilharia.cabecalho;
    
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
    [tabelaArtilheiros performSelectorInBackground:@selector(reloadData) withObject:nil];
    
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
    
    tabelaArtilheiros.hidden = NO;
    
}
@end
