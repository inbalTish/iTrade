//
//  SaleTableViewController.m
//  iTrade
//
//  Created by Inbal Tish on 8/30/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "SaleTableViewController.h"
#import "SaleViewController.h"
#import "StockTableCell.h"
#import "PurchaseAction.h"
#import "SaleAction.h"
#import "AppData.h"

@interface SaleTableViewController ()

@end

@implementation SaleTableViewController

NSArray *userStocksArray;
NSMutableDictionary *stocksDict;

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
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeStocksDictionaryWithArrays];
    stocksDict = [self removeZeroQuantityStocksFromDictionary];
    // userStocksArray = [[NSArray alloc]init]; // why no need to init?
    userStocksArray = [stocksDict allKeys]; // keys array
    [self.saleTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// shares a title and stock sign parameter with next screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.saleTableView indexPathForCell:sender];
    
    SaleViewController *nextScreen = segue.destinationViewController;
    nextScreen.title = userStocksArray[indexPath.row];
    nextScreen.chosenStockSign = userStocksArray[indexPath.row];
}

// --------------------
#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return userStocksArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = userStocksArray[indexPath.row];
    StockTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // setting values to cell views:
    Stock *stock = [self findStockObjectByKey:key];
    // company logo
    NSString *companyLogoURL = stock.company.logo;
    UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
    [cell.companyLogoImageView setImage:companyLogoImage];
    // company name
    cell.companyNameUILabel.text = stock.company.name;
    // stock sign
    cell.stockSignUILabel.text = key;
    // stock quantity (instead of price)
    int stockQuantity = [stocksDict[key] intValue];
    cell.stockQuantityUILabel.text = [NSString stringWithFormat:@"%d", stockQuantity];
    
    return cell;
}

// --------------------
#pragma mark - class methods

// makes dictionary from stocks action arrays
-(void)makeStocksDictionaryWithArrays{
    stocksDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *purchArray = AppData.sharedInstance.user.purchaseActionArray;
    for(int i = 0; i < purchArray.count; i++){
        PurchaseAction *pa = purchArray[i];
        NSString *sign = pa.purchasedStock.sign;
        int purchQuantity = [pa.purchaseQuantity intValue];
        if([stocksDict objectForKey:sign] == nil){
            [stocksDict setObject:@(purchQuantity) forKey:sign];
        }else{
            int newQuantity = [[stocksDict objectForKey:sign] integerValue];
            newQuantity += purchQuantity;
            [stocksDict setObject:@(newQuantity) forKey:sign];
        }
    }
    NSMutableArray *saleArray = AppData.sharedInstance.user.saleActionArray;
    for(int j = 0; j < saleArray.count; j++){
        SaleAction *sa = saleArray[j];
        NSString *sign2 = sa.soldStock.sign;
        int saleQuantity = [sa.saleQuantity intValue];
        if([stocksDict objectForKey:sign2] == nil){
            
        }else{
            int newQuantity2 = [[stocksDict objectForKey:sign2] integerValue];
            newQuantity2 -= saleQuantity;
            [stocksDict setObject:@(newQuantity2) forKey:sign2];
        }
    }
}

// removes stock actions with 0 quantity from display
-(NSMutableDictionary *)removeZeroQuantityStocksFromDictionary{
    NSArray *sortedArray = [stocksDict allKeys];
    for(int i = 0; i < sortedArray.count; i++){
        NSString *key = sortedArray[i];
        int *value = [[stocksDict objectForKey:key] intValue];
        if(value == 0){
            [stocksDict removeObjectForKey:key];
        }
    }
    return stocksDict;
}

// brings stock object from plist by key
-(Stock *)findStockObjectByKey:(NSString *)key{
    NSMutableArray *stocksArray = [AppData sharedInstance].stocksArray;
    for(Stock *stock in stocksArray){
        if([stock.sign isEqualToString:key]){
            return stock;
        }
    }
    return nil;
}


@end
