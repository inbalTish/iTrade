//
//  SaleTableViewController.h
//  iTrade
//
//  Created by Inbal Tish on 8/30/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *saleTableView;


@end
