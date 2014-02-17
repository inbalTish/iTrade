//
//  HistoryTableViewController.m
//  iTrade
//
//  Created by Inbal Tish on 9/5/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "StockTableCell.h"
#import "AppData.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

NSMutableArray *purchaseStockActionsArray;
NSMutableArray *saleStockActionsArray;
NSMutableArray *array;

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
   // UISegmentedControl *segmentedControl = self.tableDisplatUISegmentedControl;
    [self.tableDisplatUISegmentedControl addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
        
    purchaseStockActionsArray = AppData.sharedInstance.user.purchaseActionArray;
    saleStockActionsArray = AppData.sharedInstance.user.saleActionArray;
    
    array = purchaseStockActionsArray;
    self.tableDisplatUISegmentedControl.selectedSegmentIndex = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.historyPurchaseActionTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------------------
#pragma mark - UITableView methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int clickedSegment = [self.tableDisplatUISegmentedControl selectedSegmentIndex];
    switch (clickedSegment) {
        case 0:
        {
            PurchaseAction *purchaseAction = purchaseStockActionsArray[indexPath.row];
            StockTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            // setting values to cell views:
            // company logo
            NSString *companyLogoURL = purchaseAction.purchasedStock.company.logo;
            UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
            [cell.companyLogoImageView setImage:companyLogoImage];
            // purchase date
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"dd/MM/YY";
            cell.companyNameUILabel.text = [dateFormatter stringFromDate:purchaseAction.purchaseDate];
            // stock sign
            cell.stockSignUILabel.text = purchaseAction.purchasedStock.sign;
            // stock price
            NSString *stockPrice = [NSString stringWithFormat:@"%.4f", [purchaseAction.purchasePrice floatValue]];
            cell.stockPriceUILabel.text = stockPrice;
            // quantity
            NSString *stockQuantity = [NSString stringWithFormat:@"%d", [purchaseAction.purchaseQuantity intValue]];
            cell.stockQuantityUILabel.text = stockQuantity;
            return  cell;
        }
            break;
        case 1:
        {
            SaleAction *saleAction = saleStockActionsArray[indexPath.row];
            StockTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            // setting values to cell views:
            // company logo
            NSString *companyLogoURL = saleAction.soldStock.company.logo;
            UIImage *companyLogoImage = [UIImage imageNamed:companyLogoURL];
            [cell.companyLogoImageView setImage:companyLogoImage];
            // static lable: total revenue
            cell.companyNameUILabel.text = @"Revenue:";
            //cell.companyNameUILabel.textColor = [UIColor colorWithRed:50/255.0 green:79/255.0 blue:133/255.0 alpha:1];
            // stock sign
            cell.stockSignUILabel.text = saleAction.soldStock.sign;
            // stock price
            NSString *stocksSaleRevenue = [NSString stringWithFormat:@"%.4f", [saleAction.saleRevenue floatValue]];
            cell.stockPriceUILabel.text = stocksSaleRevenue;
            // quantity
            NSString *stockQuantity = [NSString stringWithFormat:@"%d", [saleAction.saleQuantity intValue]];
            cell.stockQuantityUILabel.text = stockQuantity;
            return  cell;
        }
            break;
    }
    return nil;
}

// --------------------
#pragma mark - UIViews methods
- (IBAction)segmentSelected:(id)sender {
    if(self.tableDisplatUISegmentedControl.selectedSegmentIndex == 0){
        array = purchaseStockActionsArray;
    }
    else{
        array = saleStockActionsArray;
    }
    [self.historyPurchaseActionTableView reloadData];
}
@end
