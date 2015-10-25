//
//  ImageButoonTestViewController.m
//  FinalProject1
//
//  Created by TAE on 14/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "ImageButoonTestViewController.h"
#import "AppDelegate.h"

@interface ImageButoonTestViewController ()

@end
#define URL @"http://taeappnewapp.esy.es/"

@implementation ImageButoonTestViewController

BOOL *btnFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    btnFlag = NO;
  //  [self addCategory:@"fname nm" secondName:@"sname hkj" email:@"email@email.com" passowrd:@"lkslfslmksmkd j"];

 //   [self loginUser:@"user1@email.com" passowrd:@"password1234"];
    [self loginUser:@"lkll" passowrd:@"lkn"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSMutableURLRequest*)getRequest:(NSString*)aURL httpMethod:(NSString*)aMethod{
    NSURL *urlGetAll = [NSURL URLWithString: aURL];
    NSLog(@"SETTING URL: %@",[urlGetAll absoluteString]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlGetAll];
    
    [request setHTTPMethod:aMethod];
    
    
    return request;
}

- (NSData*)addCategory:(NSString *)aFName secondName:(NSString *)aSName email:(NSString *)aEmail passowrd:(NSString *)aPassword{
 
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@?firstName=%@&lastName=%@&email=%@&password=%@", URL, aFName, aSName, aEmail, aPassword];
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"GET"];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aFName,@"firstName",aSName,@"lastName",aEmail,@"email",aPassword,@"password", nil];
//    
//   [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
//   // [request setHTTPBody: dict];
//
//    NSLog(@"reque URL: %@",request);
//    NSLog(@"reque URL: %@",dict);
//
    NSURLResponse *responsens = NULL;
    NSError *requestError = NULL;
//

//    
    
    
    // Create your request string with parameter name as defined in PHP file
    NSString *myRequestString = [NSString stringWithFormat:@"firstName=%@&lastName=%@&email=%@&password=%@", aFName, aSName, aEmail, aPassword];
    
    // Create Data from request
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: URL]];
    // set Request Type
    [request setHTTPMethod: @"POST"];
    // Set content-type
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    // Set Request Body
    [request setHTTPBody: myRequestData];
    // Now send a request and get Response
  //  NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    // Log Response
   // NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
   // NSLog(@"%@",response);
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
        NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *requestStr  = [[NSString alloc] initWithData:myRequestData encoding:NSUTF8StringEncoding];
    
    NSLog(@"requeststr  %@", requestStr);
        NSLog(@"**  %@", responseString);
    
    return responseData;
}




//- (void)downloadItems
//{
//    // Download the json file
//    NSURL *jsonFileUrl = [NSURL URLWithString:URL];
//    
//    // Create the request
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
//    
//    // Create the NSURLConnection
//    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
//}
//
//#pragma mark NSURLConnectionDataProtocol Methods
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    // Initialize the data object
//    _downloadedData = [[NSMutableData alloc] init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    // Append the newly downloaded data
//    [_downloadedData appendData:data];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    // Create an array to store the locations
//    NSMutableArray *_locations = [[NSMutableArray alloc] init];
//    
//    // Parse the JSON that came in
//    NSError *error;
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
//    
//    // Loop through Json objects, create question objects and add them to our questions array
//    for (int i = 0; i < jsonArray.count; i++)
//    {
//        NSDictionary *jsonElement = jsonArray[i];
//        
//        // Create a new location object and set its props to JsonElement properties
//        Location *newLocation = [[Location alloc] init];
//        newLocation.name = jsonElement[@"Name"];
//        newLocation.address = jsonElement[@"Address"];
//        newLocation.latitude = jsonElement[@"Latitude"];
//        newLocation.longitude = jsonElement[@"Longitude"];
//        
//        // Add this question to the locations array
//        [_locations addObject:newLocation];
//    }
//    
//    // Ready to notify delegate that data is ready and pass back items
//    if (self.delegate)
//    {
//        [self.delegate itemsDownloaded:_locations];
//    }
//}








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
    NSString *requestStr  = [[NSString alloc] initWithData:myRequestData encoding:NSUTF8StringEncoding];

    NSLog(@"requeststr  %@", requestStr);

    // Now send a request and get Response
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responsens error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"responsestr:  %@", responseString);
    
    return responseData;
}























- (IBAction)imageBtnActiom:(id)sender {

    //self.imageButton.currentImage.
//    [self.imageButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected]; //zero image
 //   self.imageButton.selected = NO;
   // [[self.imageButton imageView] setTintColor:[UIColor clearColor]];
    if (!btnFlag) {
        UIImage *image = [UIImage imageNamed:@"icon-upvote"];

        [self.imageButton setImage:image forState:UIControlStateNormal];
        btnFlag = YES;
        NSLog(@"%lu", btnFlag);

    } else{
        UIImage *image = [UIImage imageNamed:@"icon-upvote-active"];

        [self.imageButton setImage:image forState:UIControlStateNormal];
        btnFlag = NO;
        NSLog(@"%lu", btnFlag);

    }
  //  self.imageButton.backgroundColor = [UIColor lightGrayColor];


    NSLog(@"dasdad");

}
@end
