//
//  PurchaseTableViewController.m
//  iTrade
//
//  Created by Inbal Tish on 8/27/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "PurchaseTableViewController.h"
#import "PurchaseViewController.h"
#import "StockTableCell.h"
//#import "Stock.h"
#import "AppData.h"

@interface PurchaseTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation PurchaseTableViewController

NSMutableArray *stocksArray;

// --------------------
#pragma mark - UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    stocksArray = AppData.sharedInstance.stocksArray;
    
}

-(void)viewWillAppear:(BOOL)animated{
    // adding observer to notification center
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"stocksPriceUpdate" object:nil];
    // 
}

-(void)viewWillDisappear:(BOOL)animated{
    // removing the notification center observer
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// shares a title and stock object with next screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.purchaseTableView indexPathForCell:sender];
    Stock *stock = stocksArray[indexPath.row];
    PurchaseViewController *nextScreen = segue.destinationViewController;
    nextScreen.title = stock.sign;
    nextScreen.stock = stock;
}

// --------------------
#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return stocksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Stock *stock = stocksArray[indexPath.row];
    StockTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // setting values to cell views:
    // company logo
    NSString *companyLogoURL = stock.company.logo;
    UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
    [cell.companyLogoImageView setImage:companyLogoImage];
    // company name
    cell.companyNameUILabel.text = stock.company.name;
    // stock sign
    cell.stockSignUILabel.text = stock.sign;
    // stock price
    NSString *stockPrice = [NSString stringWithFormat:@"%.2f", [stock.price floatValue]];
    cell.stockPriceUILabel.text = stockPrice;
    
    return cell;
}

// --------------------
#pragma mark - class methods

// handls notification event
-(void)refreshTableView:(NSNotification *)notification{
    [self.purchaseTableView reloadData];
}


@end
