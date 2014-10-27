//
//  JogosTableViewController.m
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/17/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import "JogosTableViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "JogosTableViewCell.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Jogos.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JogosTableViewController ()
    @property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation JogosTableViewController
static int rodadaSelected = 0;
UIRefreshControl *refreshControl;

@synthesize jogos, responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    self.responseData = [NSMutableData data];
    [self getJogosPorRodada: rodadaSelected];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - buttons

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightDrawerButtonPress:(id)rightDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)setupLeftMenuButton {
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}

- (void)setupRightMenuButton {
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button1 addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [self.navigationItem setRightBarButtonItem:button];
}

#pragma mark - methods
- (void) getJogosPorRodada:(int) rodada{
    rodadaSelected = rodada;
    NSString * url;
    
    if ( rodada != 0 ) {
        url = [NSString stringWithFormat: @"%@?rodada=%d", URL_JOGOS, rodada];
    }
    else{
        url = URL_JOGOS;
    }
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - ui methods 

- (void) reloadInfo{
    if ( jogos != nil ){
        [self.tableView reloadData];
    }
}


#pragma mark - NSURL Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error de conexão"
                                                      message:@"Não foi possível carregar as informações. Tente novamente!"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [refreshControl endRefreshing];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                         options:0
                                                           error:nil];
    
    if ([json respondsToSelector:@selector(objectForKey:)]) {
        
        int count = (int)[[json objectForKey:@"jogos"] count];
        
        jogos = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (NSDictionary *timeJson in [json objectForKey:@"jogos"]) {
            Jogos * jogo = [Jogos objectFromDictionary:timeJson];
            [jogos addObject: jogo];
        }
        [self reloadInfo];
    }
    [refreshControl endRefreshing];
}


#pragma mark - Table view data source

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self getJogosPorRodada: rodadaSelected];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [jogos count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ( rodadaSelected == 0 ){
        return @"Rodada atual";
    }
    return [NSString stringWithFormat:@"Rodada %d", rodadaSelected];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    JogosTableViewCell *cell = (JogosTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"JogosRow" forIndexPath:indexPath];
    
    Jogos * jogo = [jogos objectAtIndex:indexPath.row];
    
    cell.siglaCasa.text = jogo.sigla_casa;
    cell.siglaFora.text = jogo.sigla_fora;
    
    cell.placarCasa.text = jogo.placar_casa;
    cell.placarFora.text = jogo.placar_fora;
    
    cell.jogoData.text = [jogo.data_completa uppercaseString];
    cell.jogoLocal.text = [jogo.local uppercaseString];
    
    
    NSURL *urlCasa = [NSURL URLWithString:[jogo getImageCasaURL]];
    [manager downloadImageWithURL:urlCasa
                          options:0
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
     {
         if (image) {
             [cell.timeCasa setImage:image]; // do something with image
         }
     }];
    cell.timeCasa.animationDuration = 0.5;
    
    NSURL *urlFora = [NSURL URLWithString:[jogo getImageForaURL]];
    [manager downloadImageWithURL:urlFora
                          options:0
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *url)
     {
         if (image) {
             [cell.timeFora setImage:image]; // do something with image
         }
     }];
    cell.timeFora.animationDuration = 0.5;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
