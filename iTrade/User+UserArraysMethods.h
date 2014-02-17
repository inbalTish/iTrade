//
//  User+UserArraysMethods.h
//  iTrade
//
//  Created by Inbal Tish on 9/12/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User.h"

@interface User (UserArraysMethods)

-(void)USupdatePurchaseArrayWithPurchaceAction:(PurchaseAction *)purchaseAction;

-(void)USupdateSaleArrayWithSaleAction:(SaleAction *)saleAction;

-(CGFloat)UScalculateTotalPurchaseActions;

-(CGFloat)UScalculateTotalSaleActions;

@end
