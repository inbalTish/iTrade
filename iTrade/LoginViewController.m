//
//  LoginViewController.m
//  iTrade
//
//  Created by JBH-User on 26/08/13.
//  Copyright (c) 2013 Inbalim. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

UIAlertView *alertLogin;

// --------------------
#pragma mark - UIViewController methods:

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // delegate textFileds for return btns on keyboard
    self.txtUserName.delegate = self;
    self.txtUserPassword.delegate = self;
    
    // setting textFields
    self.txtUserName.text = [User USbringUserNameFromUserDefaults];
    [self.txtUserPassword becomeFirstResponder];
    
    // init alertView
    alertLogin = [[UIAlertView alloc] initWithTitle:@"Login error" message:@"Password is incorrect, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// --------------------
#pragma mark - UIView methods

// return btns on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.txtUserName){
        [self.txtUserPassword becomeFirstResponder];
    }else{
        [self btnLogin:nil];
    }
    return YES;
}

// login btn
- (IBAction)btnLogin:(id)sender {
    NSString *name = self.txtUserName.text;
    NSString *password = self.txtUserPassword.text;
    int varifiedUser = [User USauthenticateLoginWithUserName: name andPassword: password];
    if(varifiedUser == YES){
        [User USsaveLastUserToDefaultsWithName:name];
        [self performSegueWithIdentifier:@"LoginToMainSegue" sender:self];
    }else{
        [alertLogin show];
       self.txtUserPassword.text = @"";
    }
}


@end
