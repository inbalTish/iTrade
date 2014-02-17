//
//  PurchaseAction.h
//  iTrade
//
//  Created by Inbal Tish on 9/17/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stock;

@interface PurchaseAction : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * purchaseDate;
@property (nonatomic, retain) NSNumber * purchasePrice;
@property (nonatomic, retain) NSNumber * purchaseQuantity;
@property (nonatomic, retain) NSNumber * stockInventory;
@property (nonatomic, retain) Stock *purchasedStock;

@end
