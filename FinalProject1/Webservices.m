//
//  Webservices.m
//  FinalProject1
//
//  Created by TAE on 19/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "Webservices.h"
#define URL @"http://taeappnewapp.esy.es/"

@implementation Webservices



- (NSData*)registerNewUser:(NSString *)aFName secondName:(NSString *)aSName email:(NSString *)aEmail passowrd:(NSString *)aPassword{

    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;

    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"firstName=%@&lastName=%@&email=%@&password=%@", aFName, aSName, aEmail, aPassword];
    NSString *loginURL = [NSString stringWithFormat:@"%@Register.php",URL];

    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: loginURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}


- (NSData*)loginUser:(NSString *)aEmail passowrd:(NSString *)aPassword{
    
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"email=%@&password=%@", aEmail, aPassword];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *loginURL = [NSString stringWithFormat:@"%@Login.php",URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: loginURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
  
    return responseData;
}



- (NSData*)addPost:(NSString *)aPostDesc userID:(NSString *)aUserID tag:(NSString *)aTag{
    //postDesc   userID   commentID   tag
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"postDesc=%@&userID=%@&tag=%@", aPostDesc, aUserID, aTag];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *addPostURL = [NSString stringWithFormat:@"%@AddPost.php",URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: addPostURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}

- (NSData*)getPost{
    //postDesc   userID   commentID   tag
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@""];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *addPostURL = [NSString stringWithFormat:@"%@GetPost.php",URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: addPostURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}
//    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:&error];

- (NSArray*)getPostArr{
    //postDesc   userID   commentID   tag
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@""];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *addPostURL = [NSString stringWithFormat:@"%@GetPost.php",URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: addPostURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&requestError];
    return jsonArr;
}

- (NSData*)getUserByID:(NSString *)aUserID{
    //postDesc   userID   commentID   tag
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"userID=%@",aUserID];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *addPostURL = [NSString stringWithFormat:@"%@GetUserById.php",URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: addPostURL]];
    
    // set Request Type
    [request setHTTPMethod: @"POST"];
    
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    
    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}


@end
