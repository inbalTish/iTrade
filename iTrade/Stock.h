//
//  Stock.h
//  iTrade
//
//  Created by Inbal Tish on 9/16/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface Stock : NSManagedObject

@property (nonatomic, retain) NSNumber * stock_id;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) Company *company;


@end
