//
//  AddPostViewController.h
//  FinalProject1
//
//  Created by TAE on 13/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPostViewController : UIViewController<UITextViewDelegate>

- (IBAction)cancleButtonAction:(id)sender;
- (IBAction)postButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *postDescriptiontextView;
@property (weak, nonatomic) IBOutlet UILabel *charactersLeftLabel;

@property (weak, nonatomic) IBOutlet UIView *viewContent;

- (IBAction)attachmentButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *attachmentImageView;

@end
