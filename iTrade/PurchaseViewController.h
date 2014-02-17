//
//  PurchaseViewController.h
//  iTrade
//
//  Created by Inbal Tish on 8/27/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"

@interface PurchaseViewController : UIViewController

@property Stock *stock;
// views:
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoUIImage;

@property (weak, nonatomic) IBOutlet UILabel *companyNameUILabel;

@property (weak, nonatomic) IBOutlet UILabel *stockSignUILabel;

@property (weak, nonatomic) IBOutlet UILabel *stockPriceUILabel;

@property (weak, nonatomic) IBOutlet UISlider *quantityUISlider;

@property (weak, nonatomic) IBOutlet UILabel *sliderValueUILabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPriceUILabel;


- (IBAction)valueChange:(id)sender;

- (IBAction)purchaseStocks:(id)sender;


@end
