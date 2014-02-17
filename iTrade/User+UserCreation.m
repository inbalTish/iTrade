//
//  User+UserCreation.m
//  iTrade
//
//  Created by Inbal Tish on 9/12/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User+UserCreation.h"

@implementation User (UserCreation)

-(id)USinitUser{
    // init instance arrays (next step is to bring them from data base..)
    if(self == [super init]){
        self.purchaseActionArray = [[NSMutableArray alloc] init];
        self.saleActionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
