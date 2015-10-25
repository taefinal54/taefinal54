//
//  PlistConnection.m
//  FinalProject1
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "PlistConnection.h"

@implementation PlistConnection
#define USERPLIST @"CurrentUser"


- (NSDictionary*)getCurrentLoggedInUser{
    NSDictionary *userDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:USERPLIST ofType:@"plist"]];
    NSLog(@"current logded in user:   %@", userDict);
    return userDict;
}


- (void)setCurrentLoggedInUser:(NSData *)aData{
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:nil];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:USERPLIST ofType:@"plist"];
    [jsonDict writeToFile:plistPath atomically:YES];
}

- (NSString*)getCurrentLoggedInUserID{
    NSDictionary *aDictionary = [self getCurrentLoggedInUser];
    NSString *userID = [(NSDictionary*)aDictionary objectForKey:@"userID"];
    NSLog(@"current logded in userid:   %@", userID);
    return userID;
}


- (NSString*)getCurrentLoggedInUserFName{
    NSDictionary *aDictionary = [self getCurrentLoggedInUser];
    NSString *firstName = [(NSDictionary*)aDictionary objectForKey:@"firstName"];
    NSLog(@"current logded in user firstName:   %@", firstName);
    return firstName;
}

- (NSString*)getCurrentLoggedInUserSName{
    NSDictionary *aDictionary = [self getCurrentLoggedInUser];
    NSString *secondName = [(NSDictionary*)aDictionary objectForKey:@"secondName"];
    
    NSLog(@"current logded in user secondName:   %@", secondName);
    return secondName;
}

- (NSString*)getCurrentLoggedInUserEmail{
    NSDictionary *aDictionary = [self getCurrentLoggedInUser];
    NSString *email = [(NSDictionary*)aDictionary objectForKey:@"email"];
    NSLog(@"current logded in user email:   %@", email);
    return email;
}





@end
