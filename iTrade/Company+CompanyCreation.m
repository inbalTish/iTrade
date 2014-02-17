//
//  Company+CompanyCreation.m
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "Company+CompanyCreation.h"

@implementation Company (CompanyCreation)

// unused
-(id)COinitWithName:(NSString*)name andLogo:(NSString*)logo{
    if(self == [super init]){
        self.name = name;
        self.logo = logo;
    }
    return self;
}



@end
