//
//  LoginViewController.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userNameTextField becomeFirstResponder];
    self.passwordTextField.delegate = self;
    self.userNameTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)addUserButtonPressed:(UIButton *)sender {
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    BOOL loginMatch = YES;
    //process the user:pass combo
    
    
    
    if(loginMatch)
    {
        [self performSegueWithIdentifier:@"startApplication" sender:self];
    }
    else{
        //if no users prompt to add user
        UIAlertController *incorrectUP = [UIAlertController alertControllerWithTitle:@"Login Failed" message:@"Username and Password do not match" preferredStyle:UIAlertControllerStyleAlert];
        
        [incorrectUP addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:incorrectUP animated:YES completion:^{
            [self.passwordTextField becomeFirstResponder];
            [self.passwordTextField selectAll:nil];
        }];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:self.userNameTextField])
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if([textField isEqual:self.passwordTextField])
    {
        [self loginButtonPressed:nil];
    }
    return YES;
}


@end
