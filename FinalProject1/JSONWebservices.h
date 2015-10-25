//
//  JSONWebservices.h
//  FinalProject1
//
//  Created by TAE on 08/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONWebservices : NSObject

-(NSMutableArray*)coreDataConnection:(NSString*)storeName;
- (void)commentDataRetrevied:(NSData*)dataResponse;
- (void)postDataRetrevied:(NSData*)dataResponse;
- (NSData*)getAllItemJSON;
- (NSMutableURLRequest*)getRequest:(NSString*)aURL httpMethod:(NSString*)aMethod;
- (NSData*)addCategory:(NSString *)aUserName PostDescription:(NSString *)aDescription;
- (NSData*)deleteCategory:(NSString*)aPostID;
- (NSData*)listCategory;
- (NSData*)getCategory;
- (NSData*)editCategory:(NSString*)aCategoryID postName:(NSString*)aName postUrlCode:(NSString*)aUrlCode;
- (NSData*)addDiscussion:(NSString *)aUserName CommentDescription:(NSString *)aDescription PostID:(NSString *)aID;




@end
