//
//  BookmarkViewController.h
//  DPRandom
//
//  Created by DODOwoo on 12-3-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookmarkViewControllerDelegate<NSObject>

-(void)LoadWebViewAndSetUrl:(NSString *)urlstring;
-(void)DeleteBookMarkWithUrl:(NSString *)urlstring Title:(NSString *)titlestring;

@end

@interface BookmarkViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {

}

@property(nonatomic, retain) NSMutableArray *bookmarktitlelist;
@property(nonatomic, retain) NSMutableArray *bookmarkurllist;
@property(nonatomic ,retain) IBOutlet UIBarButtonItem *deleteBarButton;
@property(nonatomic, retain) IBOutlet UITableView *tableview;
@property(assign, nonatomic) id<BookmarkViewControllerDelegate> bookdelegate;

- (void)backToMain;
- (IBAction)deleteBookMark:(id)sender;

@end
