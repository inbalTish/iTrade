//
//  Stock+StockCreation.m
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "Stock+StockCreation.h"
#import "AppData.h"

@implementation Stock (StockCreation)

//unused
-(id)STinitWithCompany:(Company*)company withSign:(NSString*)sign andPrice:(CGFloat)price{
    if(self == [super init]){
        self.company = company;
        self.sign = sign;
        self.price = [NSNumber numberWithFloat:price]; // price;
    }
    return self;
}


@end
