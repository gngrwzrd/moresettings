
#import "ScreenshotSettings.h"

extern NSUserDefaults * defaults;

@implementation ScreenshotSettings
@synthesize choose;
@synthesize location;

- (void) awakeFromNib {
	NSMutableDictionary * def = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"~/Desktop",@"ScreenshotLocation",nil];
	[defaults registerDefaults:def];
	NSString * dir = [defaults objectForKey:@"ScreenshotLocation"];
	[location setStringValue:dir];
	[[NSFileManager defaultManager] createDirectoryAtPath:[dir stringByExpandingTildeInPath] withIntermediateDirectories:true attributes:nil error:nil];
}

- (IBAction) chooseLocation:(id) sender {
	NSOpenPanel * open = [NSOpenPanel openPanel];
	[open setDelegate:self];
	[open setCanChooseFiles:false];
	[open setCanChooseDirectories:true];
	NSInteger res = [open runModal];
	if(res == NSFileHandlingPanelCancelButton) return;
	NSString * d = [[open directory] stringByAbbreviatingWithTildeInPath];
	[location setStringValue:d];
	[defaults setObject:d forKey:@"ScreenshotLocation"];
	[self setScreenshotLocation:d];
}

- (IBAction) defaults:(id) sender {
	NSString * dir = @"~/Screenshots";
	[location setStringValue:dir];
	[self setScreenshotLocation:dir];
}

- (void) setScreenshotLocation:(NSString *) loc {
	pid_t child = fork();
	if(child == 0) {
		char * cmd[] = {"defaults","write","com.apple.screencapture","location",(char *)[loc UTF8String],(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (void) dealloc {
	[choose release];
	[location release];
	[super dealloc];
}

@end
