//
//  BookmarkViewController.m
//  DPRandom
//
//  Created by DODOwoo on 12-3-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BookmarkViewController.h"


@implementation BookmarkViewController

@synthesize bookmarktitlelist;
@synthesize bookmarkurllist;
@synthesize bookdelegate;
@synthesize deleteBarButton;
@synthesize tableview;

#pragma mark -
#pragma mark NavigationItem Methods
- (void)backToMain{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)setRightBarButton{
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(backToMain)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
}

- (IBAction)deleteBookMark:(id)sender{
	NSLog([NSString stringWithFormat:@"delete:%@",sender]);
	[self.tableview setEditing:!self.tableview.editing animated:YES];
	
	if (self.tableview.editing) {
		NSLog(@"editing");
		[self.deleteBarButton setTitle:@"Done"];
		self.navigationItem.rightBarButtonItem = nil;
		
	}
	else {
		NSLog(@"not editing");
		[self.deleteBarButton setTitle:@"Edit"];
		[self setRightBarButton];
	}
}

#pragma mark -
#pragma mark Default Methods
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Fav Shops";
	[self setRightBarButton];

	NSArray *arrtitle = [[NSUserDefaults standardUserDefaults] arrayForKey:@"shoptitle"];
	NSArray *arrurl	= [[NSUserDefaults standardUserDefaults] arrayForKey:@"shopurl"];
	self.bookmarktitlelist = [arrtitle mutableCopy];
	self.bookmarkurllist = [arrurl mutableCopy];
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

#pragma mark -
#pragma mark Table Data Source Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookcell"];	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bookcell"];
	}
	cell.textLabel.text = [bookmarktitlelist objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [bookmarkurllist objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:@"bookmark.png"];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [bookmarktitlelist count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self.bookdelegate LoadWebViewAndSetUrl:[bookmarkurllist objectAtIndex:indexPath.row]];
	[self backToMain];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	[bookmarkurllist removeObjectAtIndex:indexPath.row];
	[bookmarktitlelist removeObjectAtIndex:indexPath.row];

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:bookmarktitlelist forKey:@"shoptitle"];
	[defaults setObject:bookmarkurllist forKey:@"shopurl"];
	//[defaults synchronize];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
