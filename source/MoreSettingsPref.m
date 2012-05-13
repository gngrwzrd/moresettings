
#import "MoreSettingsPref.h"

extern NSUserDefaults * defaults;

void sigchld(int signo) {
	int status = 0;
	while(waitpid(-1,&status,WNOWAIT) > 0);
}

@implementation MoreSettingsPref
@synthesize window;
@synthesize settings;
@synthesize container;

- (void) mainViewDidLoad {
	
	struct sigaction signals;
	bzero(&signals,sizeof(signals));
	signals.sa_handler = sigchld;
	signals.sa_flags = SA_NOCLDSTOP | SA_RESTART;
	while(sigaction(SIGCHLD,&signals,NULL) < 0);
	
	if(!defaults) defaults = [NSUserDefaults standardUserDefaults];
	NSBundle * muBundle = [NSBundle bundleForClass:[self class]];
	keyboard = [[KeyboardSettings alloc] initWithNibName:@"KeyboardSettings" bundle:muBundle];
	screenshots = [[ScreenshotSettings alloc] initWithNibName:@"ScreenshotSettings" bundle:muBundle];
	dock = [[DockSettings alloc] initWithNibName:@"DockSettings" bundle:muBundle];
	mouse = [[MouseSettings alloc] initWithNibName:@"MouseSettings" bundle:muBundle];
	initialy = [container frame].size.height + [container frame].origin.y;
	[self popupButtonDidChange:NULL];
}

- (IBAction) popupButtonDidChange:(id) sender {
	int tag = [settings selectedTag];
	[[selectedController view] removeFromSuperview];
	if(tag == 0) selectedController = keyboard;
	if(tag == 1) selectedController = screenshots;
	if(tag == 2) selectedController = dock;
	if(tag == 3) selectedController = mouse;
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
