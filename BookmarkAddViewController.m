//
//  BookmarkAddViewController.m
//  DPRandom
//
//  Created by DODOwoo on 12-3-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BookmarkAddViewController.h"

@implementation BookmarkAddViewController

@synthesize adddelegate;
@synthesize shoptitle;
@synthesize shopurl;

-(void)AddBookMark{
	NSLog([NSString stringWithFormat:@"title:%@, url:%@",self.shoptitle.text, self.shopurl.text]);
	[self.adddelegate AddBookmarkWithTitle:self.shoptitle.text URL:self.shopurl.text];
	[self dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Add Fav Shop";
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(AddBookMark)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
