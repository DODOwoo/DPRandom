//
//  DPRandomViewController.m
//  DPRandom
//
//  Created by DODOwoo on 12-3-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DPRandomViewController.h"

@implementation DPRandomViewController

@synthesize urltext;
@synthesize webView;
@synthesize actionsheet;
@synthesize arrurl;
@synthesize arrtitle;
@synthesize urltitle;

@synthesize goBackItem;
@synthesize goFowardItem;
@synthesize animateditem;

#pragma mark -
#pragma mark WebView Methods
- (void)LoadWebView:(NSString *)urlstring {
	//	[self.webView resignFirstResponder];
	[animateditem startAnimating];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0];
	webView.alpha = 0.8;
	[UIView commitAnimations];
	
	NSURL *url = [NSURL URLWithString:urlstring];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	[self.webView loadRequest:request];
	if (!self.urltext.text || [self.urltext.text length] ==0) {
		self.actionsheet.enabled = FALSE;
	}else {
		self.actionsheet.enabled = TRUE;
	}
}

-(void)LoadWebViewAndSetUrl:(NSString *)urlstring{
	//NSLog([NSString stringWithFormat:@"book to main :%@",urlstring]);
	[self.urltext setText:urlstring];
	[self LoadWebView:urlstring];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"load end");
	webView.alpha = 1.0;	
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
	animateditem.hidesWhenStopped = YES;
	[animateditem stopAnimating];
	
	self.urltitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	//NSLog([NSString stringWithFormat:@"can go back:%d",[self.webView canGoBack]]);
	self.goBackItem.enabled = [self.webView canGoBack];
	self.goFowardItem.enabled = [self.webView canGoForward];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO; // to stop it, set this to NO
}

- (IBAction)webViewGoBack{
	[self.webView goBack];
}

- (IBAction)webViewGoFoward{
	[self.webView goForward];
}

#pragma mark -
#pragma mark TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self editEnd:textField];
	return YES;	
}

- (IBAction)editEnd:(id)sender{
	NSString *url = self.urltext.text;
	if ([url rangeOfString:@"dianping.com"].length == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"人家才不是你的Safari呢" delegate:nil cancelButtonTitle:@"哼" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self LoadWebViewAndSetUrl:@"http://wap.dianping.com"];
	}
	else {
		[self LoadWebView:self.urltext.text];
	}		
	[self.urltext resignFirstResponder];
}

#pragma mark -
#pragma mark Motion Methods
- (NSString *)RandomShopID:(NSArray *)shoparray
{
	int x = arc4random() % [shoparray count];
	NSLog([NSString stringWithFormat:@"random x:%d",x]);
	return [shoparray objectAtIndex:x];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	NSLog(@"motion");
	if (motion == UIEventSubtypeMotionShake)
    {
        //NSLog(@"if shake!");
		NSArray *arr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"shshoplist"];
		NSString *strshopid = [self RandomShopID:arr];
		NSString *shopurl = [NSString stringWithFormat:@"http://wap.dianping.com/wap2/RsDetail.aspx?id=%@",strshopid];
		NSLog(shopurl);
		[self LoadWebViewAndSetUrl:shopurl];
    }
	//NSLog(@"shake!");
}

#pragma mark -
#pragma mark BarItem Click
- (IBAction)bookmarkClicked{
	NSLog(@"book mark clicked");
//	BookMarkViewController *bookmark = [[BookMarkViewController alloc] initWithNibName:@"BookMarkViewController" bundle:[NSBundle mainBundle]];
//	bookmark.bookdelegate = self;	
//	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bookmark];
//	//[bookmark.view addSubview:[bookmark.navController view]];
//	[self presentModalViewController:nav animated:YES];
}

- (IBAction)popActionSheet{
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Add To BookMark" otherButtonTitles:@"Other",@"Other2",nil];
	[sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSLog([NSString stringWithFormat:@"clicked:%d",buttonIndex]);
	//[actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
	if (buttonIndex == 0) {
//		BookMarkAddViewController *addbookmark = [[BookMarkAddViewController alloc] initWithNibName:@"BookMarkAddViewController" bundle:[NSBundle mainBundle]];
//		addbookmark.delegate = self;
//		[addbookmark view];
//		addbookmark.myurl.text = self.urltext.text;
//		addbookmark.mytitle.text = self.urltitle;
//		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addbookmark];
//		[self presentModalViewController:nav animated:YES];
	}
}

#pragma mark -
#pragma mark Default Methods
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	if (!self.urltext.text || [self.urltext.text length] ==0) {
		self.actionsheet.enabled = FALSE;
		//wap2/RsDetail.aspx?id=507330
		[self LoadWebViewAndSetUrl:@"http://wap.dianping.com/"];
	}
	self.goBackItem.enabled = FALSE;
	self.goFowardItem.enabled = FALSE;

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *temparr = [defaults arrayForKey:@"shshoplist"];
	if ([temparr count] == 0) {
		temparr = [[NSArray alloc] initWithObjects://@"507330",@"4515041",@"3578740",@"4523548",@"2925940",@"3121594",nil];
				   @"4550707",@"2032762",@"4989634",@"5157153",@"5429278",@"2244616",@"501115",@"5435096",@"5391580",@"4711908",
				   @"5567930",@"5326548",@"5356223",@"4507751",@"4500911",@"5293888",@"5300641",@"5508150",@"4522167",@"2236912",
				   @"4078315",@"5420800",@"3899659",@"5473698",@"2504440",@"505181",@"504795",@"5359245",@"2405539",@"2574211",
				   @"1961362",@"5209815",@"4272562",@"3883237",@"4172657",@"5478499",@"5332363",@"503746",@"3129469",@"2946028",
				   @"2880997",@"5135248",@"4096520",@"5424222",@"5188770",@"1945402",@"4510490",@"2873341",@"505910",@"2904247",
				   @"2278378",@"2498857",@"500887",@"3351334",@"2220496",@"5245120",@"4088803",@"2377246",@"4621391",@"501146",
				   @"2972056",@"4691491",@"4180101",@"5546648",@"2009164",@"587030",@"4281102",@"3578740",@"2800543",@"4516608",
				   @"1926859",@"4127403",@"3333472",@"2711299",@"5193483",@"5307347",@"4539031",@"2198218",@"2950450",@"5249540",
				   @"2886574",@"4523171",@"501419",@"3876475",@"500948",@"3572029",@"4135267",@"500668",@"5358070",@"4073998",
				   @"4052899",@"4217985",@"2960611",@"3500023",@"5143644",@"503113",@"5382857",@"504770",@"4271630",@"4083457",
				   @"5105079",@"507475",@"3162019",@"2287456",@"4564901",@"505797",@"4177186",@"3891871",@"506354",@"5278796",
				   @"4564176",@"4672473",@"3330310",@"3633949",@"4297374",@"502513",@"5440689",@"4126248",@"500883",@"569909",
				   @"5115653",@"5292360",@"4500494",@"503739",@"5190190",@"1934668",@"5301281",@"1947688",@"503176",@"4092751",
				   @"4169945",@"2876866",@"3224332",@"506785",@"502523",@"502567",@"2811133",@"4093975",@"4130558",@"506386",
				   @"4047859",@"2120617",@"4503789",@"3069055",@"3511363",@"5342547",@"5513727",@"1892449",@"4550060",@"4120331",
				   @"504634",@"4525087",@"5435913",@"2875636",@"4183869",@"3989161",@"2194897",@"3036454",@"584308",@"4517575",
				   @"505784",@"5327706",@"5155229",@"2313517",@"4203639",@"5506524",@"2034829",@"2514457",@"5205627",@"503215",
				   @"2196133",@"2414827",@"5444343",@"4548535",@"503154",@"5528715",@"4516603",@"503764",@"505573",@"500063",
				   @"2730220",@"5601702",@"2540248",@"5279890",@"3690400",@"4505553",@"2845705",@"2508886",@"1946194",@"5493528",
				   @"502873",@"2725975",@"3344380",@"2313757",@"4712756",@"2538064",@"3196078",@"565186",@"5330165",@"5195093",
				   @"5479533",@"3081706",@"583339",@"3377959",@"2186266",@"1965565",@"4556167",@"4618199",@"3666838",nil];
		[defaults setObject:temparr forKey:@"shshoplist"];
	}
	//[defaults synchronize];
	[temparr release];
	
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [super dealloc];
}

@end
