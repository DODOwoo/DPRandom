//
//  DPRandomViewController.h
//  DPRandom
//
//  Created by DODOwoo on 12-3-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkViewController.h"
#import "BookmarkAddViewController.h"

#define TitleKey @"shoptitle"
#define UrlKey @"shopurl"
#define ShopListKey @"shshoplist"
#define DefaultUrl @"http://wap.dianping.com/"

@interface DPRandomViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,
BookmarkViewControllerDelegate, BookmarkAddControllerDelegate> {

}

@property(nonatomic, retain) IBOutlet UITextField *urltext;
@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic ,retain) IBOutlet UIBarButtonItem *actionsheet;
@property(nonatomic ,retain) IBOutlet UIBarButtonItem *goBackItem;
@property(nonatomic ,retain) IBOutlet UIBarButtonItem *goFowardItem;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *animateditem;

@property(nonatomic, retain) NSString *urltitle;
@property (nonatomic,retain) NSArray *arrurl;
@property (nonatomic,retain) NSArray *arrtitle;

- (void)LoadWebView:(NSString *)urlstring;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
- (NSString *)RandomShopID:(NSArray *)shoparray;

- (IBAction)webViewGoBack;
- (IBAction)webViewGoFoward;
- (IBAction)editEnd:(id)sender;
- (IBAction)bookmarkClicked;
- (IBAction)popActionSheet;

@end

