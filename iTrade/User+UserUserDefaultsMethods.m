//
//  User+UserUserDefaultsMethods.m
//  iTrade
//
//  Created by Inbal Tish on 9/12/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "User+UserUserDefaultsMethods.h"

@implementation User (UserUserDefaultsMethods)

// user name and password:
+(BOOL)USauthenticateLoginWithUserName:(NSString *)name andPassword:(NSString *)password{
    NSString *savedName = @"Inbal";
    NSString *savedPassword = @"212121";
    if([name isEqualToString:savedName] && [password isEqualToString:savedPassword]){
        return YES;
    }
    return NO;
}

+(void)USsaveLastUserToDefaultsWithName:(NSString *)name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:@"user_name"];
    [defaults synchronize];
}

+(NSString*)USbringUserNameFromUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user_name = [defaults objectForKey:@"user_name"];
    if(user_name.length == 0) // for automatic setting of user name
    {
        user_name = @"Inbal";
    }
    return user_name;
}


@end
