//
//  LSCButtonTableViewCell.h
//  FinalProject1
//
//  Created by TAE on 14/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *likeImageButton;
@property (weak, nonatomic) IBOutlet UIButton *commentImageButton;
@property (weak, nonatomic) IBOutlet UIButton *ShareImageButton;
- (IBAction)ShareButtonAction:(id)sender;
- (IBAction)likeButtonAction:(id)sender;
- (IBAction)commentButtonAction:(id)sender;

@end
