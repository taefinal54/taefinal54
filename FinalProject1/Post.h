//
//  Post.h
//  FinalProject1
//
//  Created by TAE on 13/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * postDescription;
@property (nonatomic, retain) NSNumber * postID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
