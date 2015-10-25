//
//  FeedsTableViewCell.h
//  FinalProject1
//
//  Created by TAE on 02/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@property (weak, nonatomic) IBOutlet UIImageView *uncommentedImage;
@property (weak, nonatomic) IBOutlet UIImageView *commentedImage;
@property (weak, nonatomic) IBOutlet UIImageView *unlikedImage;
@property (weak, nonatomic) IBOutlet UIImageView *likedImage;

@end
