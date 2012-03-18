//
//  BookmarkAddViewController.h
//  DPRandom
//
//  Created by DODOwoo on 12-3-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookmarkAddControllerDelegate<NSObject>

-(void)AddBookmarkWithTitle:(NSString *)newtitle URL:(NSString *)newurl;

@end

@interface BookmarkAddViewController : UIViewController {

}

@property (nonatomic, retain) IBOutlet UITextField *shoptitle;
@property (nonatomic, retain) IBOutlet UITextField *shopurl;
@property (assign, nonatomic) id<BookmarkAddControllerDelegate> adddelegate;

@end
