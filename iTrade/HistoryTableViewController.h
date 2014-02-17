//
//  HistoryTableViewController.h
//  iTrade
//
//  Created by Inbal Tish on 9/5/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UISegmentedControl *tableDisplatUISegmentedControl;

@property (weak, nonatomic) IBOutlet UITableView *historyPurchaseActionTableView;



- (IBAction)segmentSelected:(id)sender;

@end
