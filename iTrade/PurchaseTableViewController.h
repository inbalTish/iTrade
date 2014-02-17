//
//  PurchaseTableViewController.h
//  iTrade
//
//  Created by Inbal Tish on 8/27/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *purchaseTableView;


@end
