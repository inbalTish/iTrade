//
//  SaleAction+SaleActionCreation.h
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "SaleAction.h"

@interface SaleAction (SaleActionCreation)

-(id)SAinitWithStock:(Stock *)stock withQuantity:(NSInteger)quantity andSalePrice:(CGFloat)salePrice;

@end
