//
//  ProfileViewController.h
//  iTrade
//
//  Created by Inbal Tish on 9/9/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// Tags: userPhotoUIImageView = 0, userNameUILabel = 1, actionTypeUILabel = 2, totalStocksUILabel = 3, totalAmountUILabel = 4.

@property (weak, nonatomic) IBOutlet UITableView *profileUITableView;


- (IBAction)logOut:(id)sender;

@end
