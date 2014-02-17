//
//  PurchaseViewController.m
//  iTrade
//
//  Created by Inbal Tish on 8/27/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "PurchaseViewController.h"
//#import "Stock.h"
#import "PurchaseAction.h"
#import "AppData.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController

int quantity;
AppData *appData;

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
    // setting views with values:
    // company logo
    NSString *companyLogoURL = self.stock.company.logo;
    UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
    [self.companyLogoUIImage setImage:companyLogoImage];
    //company name
    self.companyNameUILabel.text = self.stock.company.name;
    // stock sign
    self.stockSignUILabel.text = self.stock.sign;
    // stock price
    self.stockPriceUILabel.text = [NSString stringWithFormat:@"%@", self.stock.price];
    // total purchase price
    self.totalPriceUILabel.text = [NSString stringWithFormat:@"%@", self.stock.price];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPriceUILabel:) name:@"stocksPriceUpdate" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------------------
#pragma mark - UIView methods

// UISliderView - quantity change total cost calculation 
- (IBAction)valueChange:(id)sender {
    [self calculateTotalCost];
}

// sliderUILable - total cost calculation
-(void)calculateTotalCost{
    quantity = (int) self.quantityUISlider.value;
    self.sliderValueUILabel.text = [NSString stringWithFormat:@"%d", quantity];
    float stockPrice = [self.stockPriceUILabel.text floatValue];
    float totalCost = quantity * stockPrice;
    self.totalPriceUILabel.text = [NSString stringWithFormat:@"%f", totalCost];
}

// UIButton - purchase stocks
- (IBAction)purchaseStocks:(id)sender {
    PurchaseAction * pa = [self savePurchaseActionToCoreData];
    [appData.user USupdatePurchaseArrayWithPurchaceAction: pa];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// --------------------
#pragma mark - class methods

// handls notification event
-(void)refreshPriceUILabel:(NSNotification *)notification{
    self.stockPriceUILabel.text = [NSString stringWithFormat:@"%@", self.stock.price];
    [self calculateTotalCost];
}

// --------------------
#pragma mark - core data methods

-(PurchaseAction*)savePurchaseActionToCoreData{
    PurchaseAction *pa = [NSEntityDescription insertNewObjectForEntityForName:@"PurchaseAction" inManagedObjectContext:appData.context];
    pa.purchasedStock = self.stock;
    pa.purchasePrice = @([self.stockPriceUILabel.text floatValue]);
    pa.purchaseQuantity = @((int) self.quantityUISlider.value);
    pa.stockInventory = @((int) self.quantityUISlider.value);
    NSDate *date = [NSDate date];
    pa.purchaseDate = date;
    
    NSError *error;
    [appData.context save:&error];
    return pa;
}

@end
