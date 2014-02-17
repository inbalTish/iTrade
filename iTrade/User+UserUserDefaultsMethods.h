//
//  User+UserUserDefaultsMethods.h
//  iTrade
//
//  Created by Inbal Tish on 9/12/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User.h"

@interface User (UserUserDefaultsMethods)

+(BOOL)USauthenticateLoginWithUserName:(NSString *)name andPassword:(NSString *)password;

+(void)USsaveLastUserToDefaultsWithName:(NSString *)name;

+(NSString*)USbringUserNameFromUserDefaults;

@end
