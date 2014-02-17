//
//  LoginViewController.h
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtUserName;

@property (weak, nonatomic) IBOutlet UITextField *txtUserPassword;


- (IBAction)btnLogin:(id)sender;


@end
