//
//  User+UserArraysMethods.m
//  iTrade
//
//  Created by Inbal Tish on 9/12/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User+UserArraysMethods.h"

@implementation User (UserArraysMethods)

// update arr with every purchase action
-(void)USupdatePurchaseArrayWithPurchaceAction:(PurchaseAction *)purchaseAction{
    [self.purchaseActionArray addObject: purchaseAction];
}
// update arr with every sale action
-(void)USupdateSaleArrayWithSaleAction:(SaleAction *)saleAction{
    [self.saleActionArray addObject: saleAction];
}

-(CGFloat)UScalculateTotalPurchaseActions{
    CGFloat priceSum = 0;
    int stocksSum = 0;
    for(int i = 0; i < self.purchaseActionArray.count; i++){
        PurchaseAction *pa = self.purchaseActionArray[i];
        CGFloat price = [pa.purchasePrice floatValue];
        int quantity = [pa.purchaseQuantity intValue];
        stocksSum += quantity;
        CGFloat actionSum = price * quantity;
        priceSum += actionSum;
    }
    self.totalPurchasedStocks = stocksSum;
    return priceSum;
}

-(CGFloat)UScalculateTotalSaleActions{
    CGFloat priceSum = 0;
    int stocksSum = 0;
    for(int i = 0; i < self.saleActionArray.count; i++){
        SaleAction *sa = self.saleActionArray[i];
        CGFloat price = [sa.salePrice floatValue];
        int quantity = [sa.saleQuantity intValue];
        stocksSum += quantity;
        CGFloat actionSum = price * quantity;
        priceSum += actionSum;
    }
    self.totalSoldStocks = stocksSum;
    return priceSum;
}


@end
