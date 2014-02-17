//
//  PurchaseAction+PurchaseActionCreation.m
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "PurchaseAction+PurchaseActionCreation.h"

@implementation PurchaseAction (PurchaseActionCreation)

// unused
-(id)PAinitWithStock:(Stock *)stock withQuantity:(NSInteger)quantity andPurchasePrice:(CGFloat)purchasePrice{
    if(self == [super init]){
        self.purchasedStock = stock;
        self.purchaseQuantity = @(quantity);
        self.purchasePrice = @(purchasePrice);
        
        NSDate *date = [NSDate date];
        self.purchaseDate = date;
    }
    return self;
}

-(CGFloat)PAcalculateRevenueForPurchaseAction{
    CGFloat purchasePrice = [self.purchasePrice floatValue];
    CGFloat currentPrice = [self.purchasedStock.price floatValue]; // self.purchasedStock.price
    CGFloat revenue = currentPrice - purchasePrice;
    return revenue;
}

/*
-(NSString *)description{
    NSString *description = [NSString stringWithFormat:@"sing: %@, price: %@, quantity: %@, totalQuantity: %@", self.purchasedStock.sign, self.purchasedStock.price, self.purchaseQuantity, self.stockInventory]; 
    return description;
}
*/

@end
