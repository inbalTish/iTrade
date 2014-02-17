//
//  StockTableCell.h
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyLogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *companyNameUILabel;

@property (weak, nonatomic) IBOutlet UILabel *stockSignUILabel;

@property (weak, nonatomic) IBOutlet UILabel *stockPriceUILabel;

@property (weak, nonatomic) IBOutlet UILabel *stockQuantityUILabel;


@end
