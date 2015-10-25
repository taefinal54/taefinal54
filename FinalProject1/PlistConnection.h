//
//  PlistConnection.h
//  FinalProject1
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistConnection : NSObject

- (NSDictionary*)getCurrentLoggedInUser;
- (void)setCurrentLoggedInUser:(NSData *)aData;
- (NSString*)getCurrentLoggedInUserID;
- (NSString*)getCurrentLoggedInUserFName;
- (NSString*)getCurrentLoggedInUserSName;
- (NSString*)getCurrentLoggedInUserEmail;

@end
