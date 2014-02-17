//
//  SaleAction+SaleActionCreation.m
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "SaleAction+SaleActionCreation.h"

@implementation SaleAction (SaleActionCreation)

// unused
-(id)SAinitWithStock:(Stock *)stock withQuantity:(NSInteger)quantity andSalePrice:(CGFloat)salePrice{
    if(self == [super init]){
        self.soldStock = stock;
        self.saleQuantity = @(quantity);
        self.salePrice = @(salePrice);
        
        NSDate *date = [NSDate date];
        self.saleDate = date;
    }
    return self;
}

/*
-(NSString *)description{
    NSString *description = [NSString stringWithFormat:@"%@, %@, %@", self.soldStock.sign, self.soldStock.price, self.saleQuantity]; // @"%@, %f, %d"
    return description;
}
*/
@end
