//
//  AddPostViewController.m
//  FinalProject1
//
//  Created by TAE on 13/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "AddPostViewController.h"
#import "JSONWebservices.h"
#import "Webservices.h"
#import "PlistConnection.h"
#import "UIImage+Resize.h"
#import "UIAlertView+error.h"
#import "API.h"
#import <ImageIO/ImageIO.h>
//#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
@interface AddPostViewController ()
@property BOOL keyboardShifted;

@end
#define URL @"http://taeappnewapp.esy.es/postIndex.php"

@implementation AddPostViewController
{
  //  JSONWebservices *jsonWebServices;
    Webservices *webServices;
    PlistConnection *con;

}
- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.navigationController.navigationBarHidden = YES;

    
    [self setUpWebservices];
    [self setUpPlistConnection];
    NSLog(@"keyboard............");
    NSLog(@"x   %f", self.viewContent.frame.origin.x);//kbSize.height);
    NSLog(@"y   %f", self.viewContent.frame.origin.y);
    NSLog(@"height   %f", self.viewContent.frame.size.height);
    NSLog(@"weight   %f", self.viewContent.frame.size.width);
}

- (void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)setUpWebservices {
    webServices = [[Webservices alloc] init];
}

- (void)setUpPlistConnection {
    con = [[PlistConnection alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setUpWebservices {
//    jsonWebServices = [[JSONWebservices alloc] init];
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.postDescriptiontextView resignFirstResponder];
}

-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
}


-(void)uploadPhoto {
    //upload the image and the title to the web service
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"upload", @"command", UIImageJPEGRepresentation(self.attachmentImageView.image,70), @"file", @"postdescadm maklda klmdalkm", @"postDesc", @"29", @"userID", @"tagasphoto", @"tag", @"2", @"IdPhoto", nil] onCompletion:^(NSDictionary *json) { //fldTitle.text, @"title", nil] onCompletion:^(NSDictionary *json) {
        //completion
        if (![json objectForKey:@"error"]) {
            //success
            [[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
            
        } else {
            //error, check for expired session and if so - authorize the user
            NSString* errorMsg = [json objectForKey:@"error"];
            [UIAlertView error:errorMsg];
            if ([@"Authorization required" compare:errorMsg]==NSOrderedSame) {
                [self performSegueWithIdentifier:@"ShowLogin" sender:nil];
            }
        }
    }];
    
}

-(void)addPost {
    //upload the image and the title to the web service
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"post", @"command", @"postdescadm maklda klmdalkm", @"postDesc", @"29", @"userID", @"tagasphoto", @"tag", @"4", @"IdPhoto", nil] onCompletion:^(NSDictionary *json) { //fldTitle.text, @"title", nil] onCompletion:^(NSDictionary *json) {
        //completion
        if (![json objectForKey:@"error"]) {
            //success
            [[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your photo is uploaded" delegate:nil cancelButtonTitle:@"Yay!" otherButtonTitles: nil] show];
            
        } else {
            //error, check for expired session and if so - authorize the user
            NSString* errorMsg = [json objectForKey:@"error"];
            [UIAlertView error:errorMsg];
            if ([@"Authorization required" compare:errorMsg]==NSOrderedSame) {
                [self performSegueWithIdentifier:@"ShowLogin" sender:nil];
            }
        }
    }];
    
}
#pragma mark - Image picker delegate methods
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Resize the image from the camera
    UIImage *scaledImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(self.attachmentImageView.frame.size.width, self.attachmentImageView.frame.size.height) interpolationQuality:kCGInterpolationHigh];
    // Crop the image to a square (yikes, fancy!)
    UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width -self.attachmentImageView.frame.size.width)/2, (scaledImage.size.height -self.attachmentImageView.frame.size.height)/2, self.attachmentImageView.frame.size.width, self.attachmentImageView.frame.size.height)];
    // Show the photo on the screen
    self.attachmentImageView.image = croppedImage;
    [picker dismissModalViewControllerAnimated:NO];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    self.charactersLeftLabel.text = [NSString stringWithFormat:@"%lu characters left", 500 - textView.text.length];
    
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }

    NSLog(@"%lu", (unsigned long)[textView.text length]);
    return newLength <= 500;
}

- (IBAction)cancleButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)postButtonAction:(id)sender {
   // [jsonWebServices addCategory:@"usertest3@email.com" PostDescription:self.postDescriptiontextView.text];
    [webServices addPost:self.postDescriptiontextView.text userID:@"2" tag:@"post,test"];
    NSLog(@"%@", self.postDescriptiontextView.text);
    
    if (self.attachmentImageView.image == nil) {
        [self addPost];
        NSLog(@"Nil attachmentImageView");
    }else{
        [self uploadPhoto];
        NSLog(@"attachmentImageView");
    }
    [self dismissViewControllerAnimated:true completion:nil];

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
            self.viewContent.frame = CGRectMake(self.viewContent.frame.origin.x, (self.view.frame.size.height - kbSize.height - self.viewContent.frame.size.height)/2+60, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
            //endFrame.origin.y);
            
            
            NSLog(@"keyboard............");
            NSLog(@"x   %f", kbSize.height);//self.viewContent.frame.origin.x);
            NSLog(@"y   %f", self.viewContent.frame.origin.y);
            NSLog(@"height   %f", self.viewContent.frame.size.height);
            NSLog(@"weight   %f", self.viewContent.frame.size.width);
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
            self.viewContent.frame = CGRectMake(self.viewContent.frame.origin.x, 100, self.viewContent.frame.size.width, self.viewContent.frame.size.height);
            //self.viewContent.frame.size.width, self.view.frame.size.height);
            
            NSLog(@"keyboard hide ---............");
            NSLog(@"x   %f", self.viewContent.frame.origin.x);
            NSLog(@"y   %f", self.viewContent.frame.origin.y);
            NSLog(@"height   %f", self.viewContent.frame.size.height);
            NSLog(@"weight   %f", self.viewContent.frame.size.width);
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)attachmentButtonAction:(id)sender {
    [self takePhoto];
    
}
@end
