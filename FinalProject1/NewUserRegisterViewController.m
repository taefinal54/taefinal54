//
//  NewUserRegisterViewController.m
//  FinalProject1
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "NewUserRegisterViewController.h"
#import "Webservices.h"
#import "CSAnimationView.h"

@interface NewUserRegisterViewController ()

@end

@implementation NewUserRegisterViewController
{
    Webservices *webServices;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebservices];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUpWebservices {
    webServices = [[Webservices alloc] init];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.firstNameTextBox resignFirstResponder];
    [self.secondNameTextBox resignFirstResponder];
    [self.emailTextBox resignFirstResponder];
    [self.passwordTextBox resignFirstResponder];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerButtonAction:(id)sender {
    
    if([self.firstNameTextBox.text isEqualToString:@""] || [self.secondNameTextBox.text isEqualToString:@""] || [self.emailTextBox.text isEqualToString:@""] || [self.passwordTextBox.text isEqualToString:@""]){
        
        self.invalidLabel.text = @"All fields required";
        [self.invalidLabelView startCanvasAnimation];
        
        
        
    } else{
    
    NSString *fName = self.firstNameTextBox.text;
    NSString *sName = self.secondNameTextBox.text;
    NSString *email = self.emailTextBox.text;
    NSString *password = self.passwordTextBox.text;
    
    [webServices registerNewUser:fName secondName:sName email:email passowrd:password];
    
    }
}
@end
