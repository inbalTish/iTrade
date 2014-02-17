//
//  SaleStockViewController.h
//  iTrade
//
//  Created by Inbal Tish on 9/3/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseAction.h"

@interface SaleStockViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *companyLogoUIImage;
@property (weak, nonatomic) IBOutlet UILabel *companyNameUILabel;
@property (weak, nonatomic) IBOutlet UILabel *stockSignUILabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPriceUILabel;
@property (weak, nonatomic) IBOutlet UILabel *purchasePriceUILabel;
@property (weak, nonatomic) IBOutlet UILabel *revenueUILabel;
@property (weak, nonatomic) IBOutlet UISlider *quantityUISlider;
@property (weak, nonatomic) IBOutlet UILabel *sliderValueUILable;

@property PurchaseAction *stockForSale;


- (IBAction)sliderValueChange:(id)sender;

- (IBAction)saleStocks:(id)sender;


@end
