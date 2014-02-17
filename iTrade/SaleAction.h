//
//  SaleAction.h
//  iTrade
//
//  Created by Inbal Tish on 9/16/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stock;

@interface SaleAction : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * saleDate;
@property (nonatomic, retain) NSNumber * salePrice;
@property (nonatomic, retain) NSNumber * saleQuantity;
@property (nonatomic, retain) NSNumber * saleRevenue;
@property (nonatomic, retain) Stock *soldStock;


@end
