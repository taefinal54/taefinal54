//
//  JSONWebservices.m
//  FinalProject1
//
//  Created by TAE on 08/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "JSONWebservices.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Post.h"

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define jsonURL [NSURL URLWithString: @"https://finalproject2342.vanillacommunity.com/api/v1/"]
//#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define API_TOKEN @"838cae4843bfab3697ec0f3c80bf7c32"
#define URL @"https://finalproject2342.vanillacommunity.com"
@implementation JSONWebservices


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)dataRetrevied:(NSData*)dataResponse{
    NSError *error;
    [self addCategory:@"das@dse.com" PostDescription:@"post3 hi added  123 test"];
    //   [self deleteCategory];
    //    [self getAllItemJSON];
    //  [self listCategory];
    //  [self getCategory];
    //  [self editCategory];
    //  [self addDiscussion:@"das@dse.com" CommentDescription:@"hi added comment 123 test" PostID:@"6"];
    //   [self bookMarkDiscussion];
    //    [self bookMarkedUsersDiscussion];
    //    [self editDiscussion];
    //    [self listDiscussion];
    //   [self categoryDiscussion];
    //   [self addComment];
    // [self editComment];
    //  [self dataRetrevied1:[self listDiscussion]];
    [self postDataRetrevied:[self listCategory]];
    [self postCoreDataConnection];
    
    //  [self coreDataConnection];
}

-(NSMutableArray*)coreDataConnection:(NSString*)storeName{
    [self postDataRetrevied:[self listCategory]];

    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:storeName];
    
    NSMutableArray *coreDataArr = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for(Post *p in coreDataArr){
        NSLog(@"-----------------------------");
        NSLog(@"userName %@", p.userName);
        NSLog(@"postDescription %@", p.postDescription);
        NSLog(@"postID %@", p.postID);
    }
    return coreDataArr;
}

-(void)commentCoreDataConnection{
    
    NSMutableArray *commentArr = [self coreDataConnection:@"Comment"];
    
    for(Comment *c in commentArr){
        NSLog(@"-----------------------------");
        NSLog(@"commentid %@", c.commentID);
        NSLog(@"userName %@", c.userName);
        NSLog(@"commentDescription %@", c.commentDescription);
        NSLog(@"postID %@", c.postID);
    }
}


-(void)postCoreDataConnection{
    
    NSMutableArray *commentArr = [self coreDataConnection:@"Post"];
    
    for(Post *p in commentArr){
        NSLog(@"-----------------------------");
        NSLog(@"userName %@", p.userName);
        NSLog(@"postDescription %@", p.postDescription);
        NSLog(@"postID %@", p.postID);
    }
}

- (void)commentDataRetrevied:(NSData*)dataResponse{
    NSError *error;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:&error];
    NSArray *arr = [(NSDictionary*)jsonDict objectForKey:@"Discussions"];
    
    NSString *commentID;
    NSString *userName;
    NSString *postID;
    NSString *commentDesc;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newComment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
    
    for(NSDictionary *dict in arr){
        
        commentID = [(NSDictionary*)dict objectForKey:@"DiscussionID"];
        userName = [(NSDictionary*)dict objectForKey:@"Name"];
        postID = [(NSDictionary*)dict objectForKey:@"CategoryID"];
        commentDesc = [(NSDictionary*)dict objectForKey:@"Body"];
        
        [newComment setValue:commentID forKey:@"commentID"];
        [newComment setValue:userName forKey:@"userName"];
        [newComment setValue:[NSNumber numberWithInt:[postID intValue]] forKey:@"postID"];
        [newComment setValue:commentDesc forKey:@"commentDescription"];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed" message:[NSString stringWithFormat:@"Save core data failed %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
}


- (void)postDataRetrevied:(NSData*)dataResponse{
    NSError *error;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:dataResponse options:kNilOptions error:&error];
    NSDictionary *catDict = [(NSDictionary*)jsonDict objectForKey:@"Categories"];
    NSDictionary *catObj;
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Post"];
    NSPredicate *predicate;
    
    NSString *searchStr;
    
    
    NSString *userName;
    NSString *postID;
    NSString *postDesc;
    NSArray *results;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newPost = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:context];

    for(id key in catDict){
        searchStr = [NSString stringWithFormat:@"postID = %@", key];
        predicate = [NSPredicate predicateWithFormat:searchStr];
        
        [fetchRequest setPredicate:predicate];
        
        results = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        
        if (![results count]){
            NSLog(@"not in core data %@",searchStr);
            
            catObj = [catDict objectForKey:key];
            
            userName = [(NSDictionary*)catObj objectForKey:@"Name"];
            postID = [(NSDictionary*)catObj objectForKey:@"CategoryID"];
            postDesc = [(NSDictionary*)catObj objectForKey:@"Description"];

            [newPost setValue:userName forKey:@"userName"];
            [newPost setValue:postID forKey:@"postID"];
            [newPost setValue:postDesc forKey:@"postDescription"];
            
            NSError *error = nil;
            
            if (![context save:&error]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed" message:[NSString stringWithFormat:@"Save core data failed %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
    }
    
}


- (NSData*)getAllItemJSON{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/categories/all.json?access_token=%@", URL, API_TOKEN];
    NSURL *urlGetAll = [NSURL URLWithString: urlStr];
    
    // dispatch_async(mainQueue, ^{
    
    NSLog(@"SETTING URL: %@",[urlGetAll absoluteString]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlGetAll];
    // [request addValue:API_TOKEN forHTTPHeaderField:@"X-CM-Authorization"];
    // [request setHTTPMethod:@"GET"];
    // [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    //       [self performSelectorOnMainThread:@selector(dataRetrevied:) withObject:responseData waitUntilDone:YES];
    //  });
    return responseData;
    
}
/*
 comment  = discussion:
 comment id = discussion id
 username = name
 post id = category id
 comment description = body
 
 
 post = category:
 post id = category id
 user name = name
 — = url code = name+randomnumber
 post description = description
 */

- (NSMutableURLRequest*)getRequest:(NSString*)aURL httpMethod:(NSString*)aMethod{
    NSURL *urlGetAll = [NSURL URLWithString: aURL];
    NSLog(@"SETTING URL: %@",[urlGetAll absoluteString]);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlGetAll];
    
    [request setHTTPMethod:aMethod];
    
    [request addValue:@"json/HTML" forHTTPHeaderField:@"Content-type"];

    return request;
}

- (NSData*)addCategory:(NSString *)aUserName PostDescription:(NSString *)aDescription{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/categories/add.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSInteger randomNumber = arc4random() % 999999;
    
    NSString *urlCodeStr = [NSString stringWithFormat:@"%@%ld",aUserName,(long)randomNumber];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aUserName,@"Name",urlCodeStr,@"UrlCode",aDescription,@"Description", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}


- (NSData*)deleteCategory:(NSString*)aPostID{
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/categories/delete.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aPostID,@"CategoryID", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}



- (NSData*)listCategory{
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/categories/list.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"GET"];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}

//---------------------------------------not working
- (NSData*)getCategory{
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/categories/get.json?access_token=%@&CategoryID=6", URL, API_TOKEN];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"GET"];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
}




- (NSData*)editCategory:(NSString*)aCategoryID postName:(NSString*)aName postUrlCode:(NSString*)aUrlCode{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/categories/add.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aCategoryID,@"CategoryID",aName,@"Name",aUrlCode,@"UrlCode", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
    
    
}

- (NSData*)addDiscussion:(NSString *)aUserName CommentDescription:(NSString *)aDescription PostID:(NSString *)aID{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/add.json?access_token=%@", URL, API_TOKEN];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:aUserName,@"Name",aDescription,@"Body",@"Markdown",@"Format",aID,@"CategoryID", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
  
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
 
    return responseData;
    
}



- (NSData*)bookMarkDiscussion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/bookmark.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"taefinal54@gmail.com",@"User.Email",@"5",@"DiscussionID", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];

    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}

- (NSData*)bookMarkedUsersDiscussion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/bookmarked.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"GET"];

    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);

    return responseData;
    
}


- (NSData*)editDiscussion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/edit.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"taefinal54@gmail.com",@"User.Email",@"5",@"DiscussionID",@"new edit hey body",@"Body",@"disc  2hey",@"Name", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}

- (NSData*)listDiscussion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/list.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"GET"];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);

    return responseData;
    
}

- (NSData*)categoryDiscussion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/discussions/category.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"6",@"CategoryID", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}

- (NSData*)addComment{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/comments/add.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"11",@"DiscussionID",@"comment 5 user added",@"Body",@"asdfg@daokp.com",@"Format", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}

- (NSData*)editComment{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/comments/edit.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"CommentID",@"comment 1 added edited",@"Body", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}


- (NSData*)ssoUser{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/api/v1/comments/edit.json?access_token=%@", URL, API_TOKEN];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [self getRequest:urlStr httpMethod:@"POST"];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"finalprojectuser34@outlook.com",@"User.Email", nil];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil]];
    
    NSLog(@"reque URL: %@",request);
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    NSString *responseString  = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"**  %@", responseString);
    
    return responseData;
    
}


@end
