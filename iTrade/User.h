//
//  User.h
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseAction.h"
#import "SaleAction.h"

@interface User : NSObject

@property NSString *userName;

@property NSString *userPassword;

@property NSMutableArray *purchaseActionArray;

@property NSMutableArray *saleActionArray;

@property int totalPurchasedStocks;

@property int totalSoldStocks;



-(id)USinitUser;


@end
