//
//  PurchaseAction+PurchaseActionCreation.h
//  iTrade
//
//  Created by Inbal Tish on 9/13/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "PurchaseAction.h"

@interface PurchaseAction (PurchaseActionCreation)

-(id)PAinitWithStock:(Stock *)stock withQuantity:(NSInteger)quantity andPurchasePrice:(CGFloat)purchasePrice;

-(CGFloat)PAcalculateRevenueForPurchaseAction;

@end
