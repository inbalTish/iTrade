//
//  Company.h
//  iTrade
//
//  Created by Inbal Tish on 9/16/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stock;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Stock *stocks;


@end
