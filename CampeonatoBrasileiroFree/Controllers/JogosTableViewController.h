//
//  JogosTableViewController.h
//  CampeonatoBrasileiroFree
//
//  Created by Luis Felipe Perez on 10/17/14.
//  Copyright (c) 2014 Dataminas Tecnologia e Sistemas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JogosTableViewController : UITableViewController <NSURLConnectionDataDelegate, NSURLConnectionDelegate>{
    NSMutableArray * jogos;
//    int rodadaSelected;
}

@property(strong, nonatomic) NSMutableArray * jogos;
//@property (nonatomic) int rodadaSelected;

- (void) getJogosPorRodada:(int) rodada;
- (void)refresh:(UIRefreshControl *)refreshControl;

@end
