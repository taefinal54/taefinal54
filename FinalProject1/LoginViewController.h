//
//  LoginViewController.h
//  FinalProject1
//
//  Created by TAE on 01/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate, UITextInputDelegate>
- (IBAction)loginButtonAation:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *invalidDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *invalidLabelView;
@property (weak, nonatomic) IBOutlet UIImageView *iconMainActiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconMailDeactiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconKeyDeactiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconKeyActiveImageView;

@property (weak, nonatomic) IBOutlet UIView *viewContent;
//@property (weak, nonatomic) IBOutlet UIView *viewKeyboardBar;
- (void)keyboardWillHide:(NSNotification *)aNotification;
- (void)keyboardWillShow:(NSNotification *)aNotification;

@end
