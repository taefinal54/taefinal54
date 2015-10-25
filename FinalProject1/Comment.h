//
//  Comment.h
//  FinalProject1
//
//  Created by TAE on 13/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * commentDescription;
@property (nonatomic, retain) NSNumber * commentID;
@property (nonatomic, retain) NSNumber * postID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) Post *posts;

@end
