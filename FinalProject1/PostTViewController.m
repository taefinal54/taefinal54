//
//  FeedTableViewController.m
//  FinalProject1
//
//  Created by TAE on 08/10/2015.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "AFNetworking.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import "PostTViewController.h"
#import "FeedsTableViewCell.h"
#import "FeedsImageTableViewCell.h"
#import "Webservices.h"
#import "PlistConnection.h"

@interface PostTViewController ()

@end
static NSString * const RWBasicCellIdentifier = @"RWBasicCell";
static NSString * const RWImageCellIdentifier = @"RWImageCell";

#define kAPIHost @"http://taeappnewapp.esy.es/"

@implementation PostTViewController
{
    NSMutableArray *posTableArr;
    Webservices *webServices;
    PlistConnection *con;

}
#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
 //   posTableArr = [NSMutableArray arrayWithObjects:nil];
    //self.feedTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setUpWebservices];
    //    [self refreshData];
    //--
  //  [self parseForQuery];
    posTableArr = [NSJSONSerialization JSONObjectWithData:[webServices getPost] options:kNilOptions error:nil];

}

- (void)setUpWebservices {
    webServices = [[Webservices alloc] init];
}

- (void)setUpPlistConnection {
    con = [[PlistConnection alloc]init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self deselectAllRows];
}

- (void)deselectAllRows {
    for (NSIndexPath *indexPath in [self.feedTableView indexPathsForSelectedRows]) {
        [self.feedTableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

#pragma mark - Refresh

//- (IBAction)refreshData {
//    [self.searchTextField resignFirstResponder];
//    [self parseForQuery:self.searchTextField.text];
//}

- (void)parseForQuery{//:(NSString *)query {
    [self showProgressHUD];
    
    //    __weak typeof(self) weakSelf = self;
    //
    //    [self.parser parseRSSFeed:RWDeviantArtBaseURLString
    //                   parameters:[self parametersForQuery:query]
    //                      success:^(RSSChannel *channel) {
    //
    //                          [weakSelf convertItemsPropertiesToPlainText:channel.items];
    //                          [weakSelf setFeedItems:channel.items];
    //
    //                          [weakSelf reloadTableViewContent];
    //                          [weakSelf hideProgressHUD];
    //
    //                      } failure:^(NSError *error) {
    //
    //                          [weakSelf hideProgressHUD];
    //                          NSLog(@"Error: %@", error);
    //                      }];
    
    ///------
    NSLog(@"%@", posTableArr);
    [self hideProgressHUD];
}

- (void)showProgressHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MBProgressHUD HUDForView:self.view] setLabelText:@"Loading"];
}

//- (NSDictionary *)parametersForQuery:(NSString *)query {
//    if (query.length) {
//        return @{@"q": [NSString stringWithFormat:@"by:%@", query]};
//
//    } else {
//        return @{@"q": @"boost:popular"};
//    }
//}

- (void)hideProgressHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

//- (void)convertItemsPropertiesToPlainText:(NSArray *)items {
//    for (RSSItem *item in items) {
//        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
//        item.title = [[item.title stringByConvertingHTMLToPlainText] stringByTrimmingCharactersInSet:charSet];
//        item.mediaDescription = [[item.mediaDescription stringByConvertingHTMLToPlainText] stringByTrimmingCharactersInSet:charSet];
//        item.mediaText = [[item.mediaText stringByConvertingHTMLToPlainText] stringByTrimmingCharactersInSet:charSet];
//    }
//}

- (void)reloadTableViewContent {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.feedTableView reloadData];
        [self.feedTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [posTableArr count];
    //    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSLog(@">>>>>>>>>>>>>>>>>>>%d", indexPath.row);
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self galleryCellAtIndexPath:indexPath];
    } else {
        NSLog(@"basic cell.......");
        return [self basicCellAtIndexPath:indexPath];
    }
}

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    //    RSSItem *item = self.feedItems[indexPath.row];
    //    RSSMediaThumbnail *mediaThumbnail = [item.mediaThumbnails firstObject];
    //    return mediaThumbnail.url != nil;
    NSMutableDictionary *post = [posTableArr objectAtIndex:indexPath.row];

    return [[(NSDictionary*)post objectForKey:@"IdPhoto"]  isEqual: @"1"];
    
}

- (FeedsImageTableViewCell *)galleryCellAtIndexPath:(NSIndexPath *)indexPath {
    FeedsImageTableViewCell *cell = [self.feedTableView dequeueReusableCellWithIdentifier:RWImageCellIdentifier forIndexPath:indexPath];
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureImageCell:(FeedsImageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //    RSSItem *item = self.feedItems[indexPath.row];
    //    [self setTitleForCell:cell item:item];
    //    [self setSubtitleForCell:cell item:item];
    //    [self setImageForCell:(id)cell item:item];
    // Set the data for this cell:
//    Post *post = [posTableArr objectAtIndex:indexPath.row];
//    
//    cell.nameDetailLabel.text = post.userName;
//    cell.contentDetailLabel.text = post.postDescription;
//    cell.profilePicImageView.image = [UIImage imageNamed:@"content-avatar-default"];
    NSMutableDictionary *post = [posTableArr objectAtIndex:indexPath.row];

    NSString *postUserID = [(NSDictionary*)post objectForKey:@"userID"];
    
    NSArray *userDictArr = [NSJSONSerialization JSONObjectWithData:[webServices getUserByID:postUserID] options:kNilOptions error:nil];
    NSDictionary *userDict = [userDictArr objectAtIndex:0];
    cell.nameDetailLabel.text = [NSString stringWithFormat:@"%@ %@",[(NSDictionary*)userDict objectForKey:@"firstName"],[(NSDictionary*)userDict objectForKey:@"lastName"]];
    cell.contentNameLabel.text = @"";
    
    cell.contentDetailLabel.text = [(NSDictionary*)post objectForKey:@"postDesc"];
    cell.profilePicImageView.image = [UIImage imageNamed:@"content-avatar-default"];
    cell.timeDetailLabel.text = [(NSDictionary*)post objectForKey:@"postDate"];
    
    //this will set the image when loading is finished
   // dispatch_async(dispatch_get_main_queue(), ^{
        [self setImageForCell:cell item:[(NSDictionary*)post objectForKey:@"postID"]];
        //reload will display the images
    //    [self reloadTableViewContent];
  //  });
}

- (void)setImageForCell:(FeedsImageTableViewCell *)cell item:(NSString *)item {
//    RSSMediaThumbnail *mediaThumbnail = [item.mediaThumbnails firstObject];
//
//    // mediaThumbnails are generally ordered by size,
//    // so get the second mediaThumbnail, which is a
//    // "medium" sized image
//
//    if (item.mediaThumbnails.count >= 2) {
//        mediaThumbnail = item.mediaThumbnails[1];
//    } else {
//        mediaThumbnail = [item.mediaThumbnails firstObject];
//    }
    NSString* urlString = [NSString stringWithFormat:@"%@upload/%@.jpeg", kAPIHost, item];

//    [cell.feedPicImageView setImage:nil];
//    [cell.feedPicImageView setImageWithURL:[NSURL URLWithString:urlString]];
    
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //this will start the image loading in background
    dispatch_async(concurrentQueue, ^{
        NSURL *imageURL = [NSURL URLWithString:urlString];

        NSData *image = [[NSData alloc] initWithContentsOfURL:imageURL];
        NSLog(@"+++++++++++++%@", urlString);

        
        if (image !=nil){
            
            
            
            //this will set the image when loading is finished
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.feedPicImageView.image = [UIImage imageWithData:image];
                //reload will display the images
          //      [self.feedTableView reloadData];
//                        [self reloadTableViewContent];

            });
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.feedPicImageView.image = [UIImage imageNamed:@"house.jpeg"];
                //reload will display the images
        //        [self reloadTableViewContent];
            });
            
        }
        
        
    });
    
//    [cell.progressIndicator stopAnimating];
    
    
    
   // return cell;
    

}

- (FeedsTableViewCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    FeedsTableViewCell *cell = [self.feedTableView dequeueReusableCellWithIdentifier:RWBasicCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(FeedsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *post = [posTableArr objectAtIndex:indexPath.row];
    //    if(indexPath.row==0){
    //    cell.nameDetailLabel.text = @"username1234";//post.userName;
    //    cell.contentDetailLabel.text = @"username1234 post sjdlkndnakdn";//post.postDescription;
    //    }
    //    if(indexPath.row==1){
    //        cell.nameDetailLabel.text = @"wqqdsdafsffd";//post.userName;
    //        cell.contentDetailLabel.text = @"safsfsadfsfsafd post sjdlkndnakdn";//post.postDescription;
    //    }
    NSString *postUserID = [(NSDictionary*)post objectForKey:@"userID"];

    NSArray *userDictArr = [NSJSONSerialization JSONObjectWithData:[webServices getUserByID:postUserID] options:kNilOptions error:nil];
    NSDictionary *userDict = [userDictArr objectAtIndex:0];
    cell.nameDetailLabel.text = [NSString stringWithFormat:@"%@ %@",[(NSDictionary*)userDict objectForKey:@"firstName"],[(NSDictionary*)userDict objectForKey:@"lastName"]];
    cell.contentNameLabel.text = @"";
    
    cell.contentDetailLabel.text = [(NSDictionary*)post objectForKey:@"postDesc"];
    cell.profilePicImageView.image = [UIImage imageNamed:@"content-avatar-default"];
    cell.timeDetailLabel.text = [(NSDictionary*)post objectForKey:@"postDate"];
    
//    NSLog(@"table post: %@", cell.contentDetailLabel.text);
//    
//    
//    
//    
//    
//    
//    NSLog(@"username:  %@", [(NSDictionary*)userDict objectForKey:@"firstName"]);
//    NSLog(@"username:  %@", [(NSDictionary*)userDict objectForKey:@"lastName"]);
//    
//    
//    // NSDictionary *userDict = [webServices getUserByID:postUserID];
//    
    
    NSLog(@"------------%@" , [(NSDictionary*)post objectForKey:@"postID"]);
    NSLog(@"arrsize:  %lu", (unsigned long)[posTableArr count]);
    NSLog(@"index:  %ld", (long)indexPath.row);

    
}

//- (void)setTitleForCell:(FeedsTableViewCell *)cell item:(Post *)item {
//    NSString *title = item.title ?: NSLocalizedString(@"[No Title]", nil);
//    [cell.titleLabel setText:title];
//}

//- (void)setSubtitleForCell:(FeedsTableViewCell *)cell item:(Post *)item {
//    NSString *subtitle = item.mediaText ?: item.mediaDescription;
//
//    // Some subtitles can be really long, so only display the
//    // first 200 characters
//    if (subtitle.length > 200) {
//        subtitle = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:200]];
//    }
//
//    [cell.subtitleLabel setText:subtitle];
//}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self heightForImageCellAtIndexPath:indexPath];
    } else {
        NSLog(@"height post: %f", [self heightForBasicCellAtIndexPath:indexPath]);
        
        return [self heightForBasicCellAtIndexPath:indexPath];
    }
}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath {
    static FeedsImageTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.feedTableView dequeueReusableCellWithIdentifier:RWImageCellIdentifier];
    });
    
    [self configureImageCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static FeedsTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.feedTableView dequeueReusableCellWithIdentifier:RWBasicCellIdentifier];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    
    NSLog(@"--------------");
    NSLog(@"arrsize:  %lu", (unsigned long)[posTableArr count]);
    NSLog(@"index:  %ld", (long)indexPath.row);
    
    NSDictionary *post = [posTableArr objectAtIndex:indexPath.row];
    
    NSLog(@"height post: %@", [(NSDictionary*)post objectForKey:@"postDesc"]);
    NSString *tempStr = [(NSDictionary*)post objectForKey:@"postDesc"];
    return [self calculateHeightForConfiguredSizingCell:sizingCell] + [tempStr boundingRectWithSize:CGSizeMake(sizingCell.contentDetailLabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica Neue" size:17]} context:nil].size.height+ 130.0f;
    
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.feedTableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isLandscapeOrientation]) {
        if ([self hasImageAtIndexPath:indexPath]) {
            return 140.0f;
        } else {
            return 120.0f;
        }
    } else {
        if ([self hasImageAtIndexPath:indexPath]) {
            return 235.0f;
        } else {
            return 155.0f;
        }
    }
}

- (BOOL)isLandscapeOrientation {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self refreshData];
//    return NO;
//}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    RSSItem *item = self.feedItems[indexPath.row];
//    
//    RWDetailViewController *viewController = [segue destinationViewController];
//    viewController.item = item;
//}

@end
