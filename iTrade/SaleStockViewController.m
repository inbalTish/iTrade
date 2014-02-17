//
//  SaleStockViewController.m
//  iTrade
//
//  Created by Inbal Tish on 9/3/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "SaleStockViewController.h"
#import "SaleAction.h"
#import "PurchaseAction.h"
#import "AppData.h"

@interface SaleStockViewController ()

@end

@implementation SaleStockViewController

AppData *appData;
int quantity;

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
    appData = [AppData sharedInstance];
    // setting values to views:
    // company logo
    NSString *companyLogoURL = self.stockForSale.purchasedStock.company.logo;
    UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
    [self.companyLogoUIImage setImage:companyLogoImage];
    // company name
    NSString *companyName = self.stockForSale.purchasedStock.company.name;
    self.companyNameUILabel.text = companyName;
    // stock sign
    NSString *sign = self.stockForSale.purchasedStock.sign;
    self.stockSignUILabel.text = sign;
    // stock purchase price
    NSString *purchasePrice = [NSString stringWithFormat:@"%@", self.stockForSale.purchasePrice];
    self.purchasePriceUILabel.text = purchasePrice;
    // stock current price - connected to notification observer
    NSString *currentPrice = [NSString stringWithFormat:@"%@", self.stockForSale.purchasedStock.price];
    self.currentPriceUILabel.text = currentPrice;
    // revenue calculation - refresh with notification
    CGFloat saleRevenue = [self calculateTotalSaleRevenue];
    self.revenueUILabel.text = [NSString stringWithFormat:@"%f", saleRevenue];
    // stock purchase quantity (for slider max value)
    int stockSaleQuantity = [self.stockForSale.purchaseQuantity intValue]; // stockForSale is PurchaseAction object
    self.quantityUISlider.maximumValue = stockSaleQuantity;
}

-(void)viewWillAppear:(BOOL)animated{
    // adding observer to notification center
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentPrice:) name:@"stocksPriceUpdate" object:nil];
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

// --------------------
#pragma mark - UIView methods

- (IBAction)sliderValueChange:(id)sender {
    quantity = (int) self.quantityUISlider.value;
    self.sliderValueUILable.text = [NSString stringWithFormat:@"%d", quantity];
    self.revenueUILabel.text = [NSString stringWithFormat:@"%f", [self calculateTotalSaleRevenue]];
}

- (IBAction)saleStocks:(id)sender {
    SaleAction *sa = [self saveSaleActionToCoreData];
    [appData.user USupdateSaleArrayWithSaleAction:sa];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

// --------------------
#pragma mark - class methods

// sliderUILable - total cost calculation
-(CGFloat)calculateTotalSaleRevenue{
    quantity = (int) self.quantityUISlider.value;
    CGFloat saleRevenue = [self.stockForSale PAcalculateRevenueForPurchaseAction];
    return saleRevenue * quantity;
}

// handels notification event
-(void)refreshCurrentPrice:(NSNotification *)notification{
    self.currentPriceUILabel.text = [NSString stringWithFormat:@"%@", self.stockForSale.purchasedStock.price];
    self.revenueUILabel.text = [NSString stringWithFormat:@"%f", [self calculateTotalSaleRevenue]]; 
}

// --------------------
#pragma mark - core data methods

-(SaleAction*)saveSaleActionToCoreData{
    SaleAction *sa = [NSEntityDescription insertNewObjectForEntityForName:@"SaleAction" inManagedObjectContext:appData.context];
    sa.soldStock = self.stockForSale.purchasedStock;
    NSDate *date = [NSDate date];
    sa.saleDate = date;
    sa.salePrice = @([self.currentPriceUILabel.text floatValue]);
    sa.saleQuantity = @((int) self.quantityUISlider.value);
    sa.saleRevenue = @([self.revenueUILabel.text floatValue]);
    // updating stockInventory property of PurchaseAction object
    self.stockForSale.stockInventory = @([self.stockForSale.stockInventory floatValue] - (int)self.quantityUISlider.value);     

    NSError *error;
    [appData.context save:&error];
    return sa;
}


@end
