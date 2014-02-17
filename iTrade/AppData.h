//
//  AppData.h
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "AppDelegate.h"


@interface AppData : NSObject <NSURLConnectionDataDelegate>

@property NSMutableArray *stocksArray;

@property User *user;

@property (nonatomic, strong) NSManagedObjectContext *context;


+(AppData *)sharedInstance;


@end
