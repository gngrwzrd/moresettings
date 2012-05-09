
#import "MoreSettingsPref.h"

extern NSUserDefaults * defaults;

@implementation MoreSettingsPref
@synthesize window;
@synthesize settings;
@synthesize container;

- (void) mainViewDidLoad {
	if(!defaults) defaults = [NSUserDefaults standardUserDefaults];
	NSBundle * muBundle = [NSBundle bundleForClass:[self class]];
	keyboard = [[KeyboardSettings alloc] initWithNibName:@"KeyboardSettings" bundle:muBundle];
	screenshots = [[ScreenshotSettings alloc] initWithNibName:@"ScreenshotSettings" bundle:muBundle];
	dock = [[DockSettings alloc] initWithNibName:@"DockSettings" bundle:muBundle];
	initialy = [container frame].size.height + [container frame].origin.y;
	[self popupButtonDidChange:NULL];
}

- (IBAction) popupButtonDidChange:(id) sender {
	int tag = [settings selectedTag];
	[[selectedController view] removeFromSuperview];
	if(tag == 0) selectedController = keyboard;
	if(tag == 1) selectedController = screenshots;
	if(tag == 2) selectedController = dock;
	[[[self mainView] superview] setNeedsDisplay:true];
	[container addSubview:[selectedController view]];
}

- (IBAction) gngrwzrd:(id) sender {
	NSURL * url = [NSURL URLWithString:@"http://gngrwzrd.com"];
	[[NSWorkspace sharedWorkspace] openURL:url];
}

- (void) dealloc {
	[keyboard release];
	[super dealloc];
}

@end
