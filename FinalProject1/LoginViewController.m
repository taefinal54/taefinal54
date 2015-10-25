//
//  LoginViewController.m
//  FinalProject1
//
//  Created by TAE on 01/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "LoginViewController.h"
#import "Webservices.h"
#import "CSAnimationView.h"
#import "PlistConnection.h"

@interface LoginViewController ()
@property BOOL keyboardShifted;

@end

@implementation LoginViewController
{
    CSAnimationView * animationView;
    Webservices *webServices;
    PlistConnection *plistConnection;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebservices];
    [self setUpPlistConnection];
    
    self.iconKeyActiveImageView.hidden = YES;
    self.iconMainActiveImageView.hidden = YES;
    
//    NSLog(@"x   %f", self.viewContent.frame.origin.x);
//    NSLog(@"y   %f", self.viewContent.frame.origin.y);
//    NSLog(@"height   %f", self.viewContent.frame.size.height);
//    NSLog(@"weight   %f", self.viewContent.frame.size.width);



}

- (void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyPressed:) name: UITextViewTextDidChangeNotification object: nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpWebservices {
    webServices = [[Webservices alloc] init];
}

- (void)setUpPlistConnection {
    plistConnection = [[PlistConnection alloc]init];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.emailAddressTextField && ![string isEqualToString:@""]){
//        NSLog(@"printed.......");
        self.iconMainActiveImageView.hidden = NO;
        self.iconMailDeactiveImageView.hidden = YES;
    } else if (textField == self.emailAddressTextField && [string isEqualToString:@""] && range.location == 0){
//        NSLog(@"Emptied");
        self.iconMainActiveImageView.hidden = YES;
        self.iconMailDeactiveImageView.hidden = NO;
    }
    
    if(textField == self.passwordTextField && ![string isEqualToString:@""]){
//        NSLog(@"printed.......");
        self.iconKeyActiveImageView.hidden = NO;
        self.iconKeyDeactiveImageView.hidden = YES;
    } else if (textField == self.passwordTextField && [string isEqualToString:@""] && range.location == 0){
//        NSLog(@"Emptied");
        self.iconKeyActiveImageView.hidden = YES;
        self.iconKeyDeactiveImageView.hidden = NO;
    }
    
    if(![self.emailAddressTextField.text isEqualToString:@""] || ![self.passwordTextField.text isEqualToString:@""]){
        
        self.invalidDetailLabel.text = @"";
        
    }

    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.emailAddressTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}


// Keyboard Notifications
static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (!self.keyboardShifted) {
        NSDictionary *userInfo = [aNotification userInfo];
        self.keyboardShifted = YES;
        NSValue *animationCurve = [[aNotification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey];
        UIViewAnimationCurve curve;
        [animationCurve getValue:&curve];
        
        CGFloat duration = [[[aNotification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

        CGRect endFrame;
        [[[aNotification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&endFrame];
        endFrame = [self.view convertRect:endFrame fromView:nil];
        
        [UIView animateWithDuration:duration delay:0.0 options:(animationOptionsWithCurve(curve)) animations:^{
//            self.view.frame.size.height - kbSize.height - self.viewContent.frame.size.height
            // Rescale the content view to fit with the keyboard
            self.viewContent.frame = CGRectMake(self.viewContent.frame.origin.x, self.view.frame.size.height - kbSize.height - self.viewContent.frame.size.height, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
            //endFrame.origin.y);

            
//            NSLog(@"keyboard............");
//            NSLog(@"x   %f", kbSize.height);//self.viewContent.frame.origin.x);
//            NSLog(@"y   %f", self.viewContent.frame.origin.y);
//            NSLog(@"height   %f", self.viewContent.frame.size.height);
//            NSLog(@"weight   %f", self.viewContent.frame.size.width);

            // Orient keyboard bar above keyboard
//            self.viewKeyboardBar.frame = CGRectMake(self.viewKeyboardBar.frame.origin.x, endFrame.origin.y - self.viewKeyboardBar.frame.size.height, self.viewKeyboardBar.frame.size.width, self.viewKeyboardBar.frame.size.height);
//            
            // Allow for additional animations
            [self willResizeForShowingKeyboardFrame:endFrame withDuration:duration];
            
        } completion:^(BOOL finished) {
            
            // Allow for additional operations after showing keyboard
            [self didResizeForShowingKeyboard];
            
        }];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.keyboardShifted) {
        NSValue *animationCurve = [[aNotification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey];
        UIViewAnimationCurve curve;
        [animationCurve getValue:&curve];
        
        CGFloat duration = [[[aNotification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        CGRect endFrame;
        [[[aNotification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&endFrame];
        endFrame = [self.view convertRect:endFrame fromView:nil];
        
        [UIView animateWithDuration:duration delay:0.0 options:(animationOptionsWithCurve(curve)) animations:^{
            
            // Resize the content view to fill the screen vertically
            self.viewContent.frame = CGRectMake(self.viewContent.frame.origin.x, 200, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
                                                //self.viewContent.frame.size.width, self.view.frame.size.height);
            
//            NSLog(@"keyboard hide ---............");
//            NSLog(@"x   %f", self.viewContent.frame.origin.x);
//            NSLog(@"y   %f", self.viewContent.frame.origin.y);
//            NSLog(@"height   %f", self.viewContent.frame.size.height);
//            NSLog(@"weight   %f", self.viewContent.frame.size.width);
//            // Hide keyboard bar
//            self.viewKeyboardBar.frame = CGRectMake(self.viewKeyboardBar.frame.origin.x, self.view.frame.size.height, self.viewKeyboardBar.frame.size.width, self.viewKeyboardBar.frame.size.height);
            
            // Allow for additional animations
            [self willResizeForHidingKeyboardFrame:endFrame withDuration:duration];
            
        } completion:^(BOOL finished) {
            self.keyboardShifted = NO;
            
            // Allow for additional operations after hiding keyboard
            [self didResizeForHidingKeyboard];
            
        }];
    }
    
}

- (void)willResizeForShowingKeyboardFrame:(CGRect)keyboardFrame withDuration:(CGFloat)duration
{
}

- (void)willResizeForHidingKeyboardFrame:(CGRect)keyboardFrame withDuration:(CGFloat)duration
{
}

- (void)didResizeForShowingKeyboard
{
}

- (void)didResizeForHidingKeyboard
{
}


- (void)dealloc
{
    // Unregister from notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    NSLog(@"textViewShouldEndEditing:");
//    textView.backgroundColor = [UIColor whiteColor];
//    return YES;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if(![self.emailAddressTextField.text isEqualToString:@""]){
//        //NSLog(@"printed.......");
//    }
//    
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"stateredsdsmnfsafku.hsbkj.f");
//}
//
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
- (IBAction)loginButtonAation:(id)sender {
    
    if([self.emailAddressTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]){
        
        self.invalidDetailLabel.text = @"Please enter email and password.";
        [self.invalidLabelView startCanvasAnimation];
        
//        [plistConnection getCurrentLoggedInUserID];
//        [plistConnection getCurrentLoggedInUserFName];
//        [plistConnection getCurrentLoggedInUserSName];
//        [plistConnection getCurrentLoggedInUserEmail];

//        [webServices addPost:@"lafknfnfwnfskfnsnsfjfnsafnjsadn,sadfnsafjksajknfsajknfdjskdfejkrferoirn   fkjsafdja fskfdenrf safs fsfekw fsa dfsa fskjfrk as fjksaf sf sfksafkj sa fjsafj ewf akjfs kjfsakf fe sfjk saf sadf e fow fwfe wefjk ekjf skckjzc.skds jkfs jkc jsdc sd csdfjs fkakdfjasjk dfasjf sadfsafaskjfkjasdf dksajaskdf sjafdkjasf sak fwoeiwiorwioernwrjkwr wkjrwk rwkj sadsa sdmm d,a" userID:@"29" tag:@"test"];
//        
        [webServices getPost];
        
        [webServices getUserByID:@"26"];
    } else{
        
        NSString *email = self.emailAddressTextField.text;
        NSString *password = self.passwordTextField.text;
        
        NSData *loggInUser = [webServices loginUser:email passowrd:password];
        [plistConnection setCurrentLoggedInUser:loggInUser];
    }
}
//
//-(void) keyPressed: (NSNotification*) notification
//{
//    if(![self.emailAddressTextField.text isEqualToString:@""]){
//        NSLog(@"printed.......");
//    }
//
//}

@end
