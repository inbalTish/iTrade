//
//  User.m
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User.h"

@implementation User
// "US" is the class abbreviation

-(id)USinitUser{
    // unused
    if(self == [super init]){
        self.purchaseActionArray = [[NSMutableArray alloc] init];
        self.saleActionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
