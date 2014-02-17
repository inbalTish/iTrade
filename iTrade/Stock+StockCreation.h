//
//  Stock+StockCreation.h
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "Stock.h"

@interface Stock (StockCreation)

-(id)STinitWithCompany:(Company*)company withSign:(NSString*)sign andPrice:(CGFloat)price;

@end
