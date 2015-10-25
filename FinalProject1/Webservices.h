//
//  Webservices.h
//  FinalProject1
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Webservices : NSObject

- (NSData*)loginUser:(NSString *)aEmail passowrd:(NSString *)aPassword;
- (NSData*)registerNewUser:(NSString *)aFName secondName:(NSString *)aSName email:(NSString *)aEmail passowrd:(NSString *)aPassword;
- (NSData*)addPost:(NSString *)aPostDesc userID:(NSString *)aUserID tag:(NSString *)aTag;
- (NSData*)getPost;
- (NSArray*)getPostArr;
- (NSData*)getUserByID:(NSString *)aUserID;
@end
