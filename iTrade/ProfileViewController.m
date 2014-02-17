//
//  ProfileViewController.m
//  iTrade
//
//  Created by Inbal Tish on 9/9/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "AppData.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

User *user;

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
    user = AppData.sharedInstance.user;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.profileUITableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// --------------------
#pragma mark - UITableView methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return 2;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier;
    if(indexPath.section == 0){
        identifier = @"userCell";
    }else{
       identifier = @"actionCell"; 
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(indexPath.section == 0){
        UIImageView *userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(9, 7, 30, 30)];
        [userPhoto viewWithTag:0];
        [userPhoto setImage:[UIImage imageNamed:@"profile_icon.png"]];
        UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 130, 22)];
        [userNameLabel viewWithTag:1];
        userNameLabel.text = user.userName;
        
        [cell.contentView addSubview:userPhoto];
        [cell.contentView addSubview:userNameLabel];
        
    }else{
        UILabel *actionTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        [actionTypeLabel viewWithTag:2];
        UILabel *stocksQuantityLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 23, 60, 20)];
        [stocksQuantityLabel viewWithTag:3];
        UILabel *totalAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 23, 100, 20)];
        [totalAmountLabel viewWithTag:4];
        if(indexPath.row == 0){
            actionTypeLabel.numberOfLines = 2;
            actionTypeLabel.text = @"Purchased \n stocks";
            totalAmountLabel.text = [NSString stringWithFormat:@"%.2f", [user UScalculateTotalPurchaseActions]]; // must come before calling user.totalPurchasedStocks
            stocksQuantityLabel.text = [NSString stringWithFormat:@"%d", user.totalPurchasedStocks];
        }else if (indexPath.row == 1){
            actionTypeLabel.text = @"Sold stocks";
            totalAmountLabel.text = [NSString stringWithFormat:@"%.2f", [user UScalculateTotalSaleActions]]; // must come before calling user.totalSoldStocks
            stocksQuantityLabel.text = [NSString stringWithFormat:@"%d", user.totalSoldStocks ];
        }
        
        [cell.contentView addSubview:actionTypeLabel];
        [cell.contentView addSubview:totalAmountLabel];
        [cell.contentView addSubview:stocksQuantityLabel];
        
    }
    return cell;
}

// --------------------
#pragma mark - UIViews methods

- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
