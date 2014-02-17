//
//  SaleViewController.m
//  iTrade
//
//  Created by Inbal Tish on 8/30/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "SaleViewController.h"
#import "StockTableCell.h"
#import "SaleStockViewController.h"
#import <Foundation/Foundation.h>
#import "AppData.h"


@interface SaleViewController ()

@end

@implementation SaleViewController

NSMutableArray *singleStockArray;

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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self makeSpecificStockActionArray];
    [self.singleStockUITableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.singleStockUITableView indexPathForCell:sender];
    SaleStockViewController *nextScreen = segue.destinationViewController;
    PurchaseAction *stockForSale = singleStockArray[indexPath.row];
    nextScreen.title = stockForSale.purchasedStock.sign;
    nextScreen.stockForSale = stockForSale; // purchase action object
}

// --------------------
#pragma mark - tableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return singleStockArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StockTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    PurchaseAction *purchaseAction = singleStockArray[indexPath.row];
    // setting values to cell views:
    // company logo
    NSString *companyLogoURL = purchaseAction.purchasedStock.company.logo;
    UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
    [cell.companyLogoImageView setImage:companyLogoImage];
    // stock price
    NSString *stockPrice = [NSString stringWithFormat:@"%@", purchaseAction.purchasePrice];
    cell.stockPriceUILabel.text = stockPrice;
    // stock quantity (Inventory)
    int stockSaleQuantity = [purchaseAction.stockInventory intValue];
    cell.stockQuantityUILabel.text = [NSString stringWithFormat:@"%d", stockSaleQuantity];
    
    return cell;
}

// --------------------
#pragma mark - class methods

// make purchase array for specific stock (by its sign)
-(void)makeSpecificStockActionArray{
    singleStockArray = [[NSMutableArray alloc]init];
    NSMutableArray *purchArray = AppData.sharedInstance.user.purchaseActionArray;
    CGFloat price;
    int quantity;
    for(int i = 0; i < purchArray.count; i++){
        PurchaseAction *pa = purchArray[i];
        NSString *sign = pa.purchasedStock.sign;
        price = [pa.purchasePrice floatValue];
        quantity = [pa.purchaseQuantity intValue];
        if([sign isEqualToString:self.chosenStockSign]){
            [singleStockArray addObject:pa]; // array of purchaseAction objects
        } 
    }
}


@end
