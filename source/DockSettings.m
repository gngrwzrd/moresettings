
#import "DockSettings.h"

@interface DockSettings ()
@end

#define DOCK_SHOW_DELAY_KEY @"DockShowDelay"

@implementation DockSettings

- (void) awakeFromNib {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary * def = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0.2",DOCK_SHOW_DELAY_KEY,nil];
	[defaults registerDefaults:def];
	NSString * val = [defaults objectForKey:DOCK_SHOW_DELAY_KEY];
	[_delayField setStringValue:val];
}

- (IBAction) onDelayStepperChange:(id) sender {
	float val = [_delayStepper floatValue];
	NSString * label = [NSString stringWithFormat:@"%.1f",val];
	[_delayField setStringValue:label];
	[self updateDockShowDelay:val];
}

- (void) updateDockShowDelay:(float) delay {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSString stringWithFormat:@"%1.f",delay] forKey:DOCK_SHOW_DELAY_KEY];
	[defaults synchronize];
	
	pid_t child = fork();
	if(child == 0) {
		//defaults delete com.apple.Dock autohide-delay
		char buf[32] = {0};
		snprintf(buf,32,"%.1f",delay);
		char * cmd[] = {"defaults","write","com.apple.Dock","autohide-delay","-float",buf,(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (IBAction) defaults:(id) sender {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:@"0.2" forKey:DOCK_SHOW_DELAY_KEY];
	[defaults synchronize];
	[_delayField setStringValue:@"0.2"];
	
	pid_t child = fork();
	if(child == 0) {
		//defaults delete com.apple.Dock autohide-delay
		char * cmd[] = {"defaults","delete","com.apple.Dock","autohide-delay",(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (IBAction) onKillDock:(id) sender {
	pid_t child = fork();
	if(child == 0) {
		char * cmd[] = {"killall","Dock",(char *)0};
		execvp("/usr/bin/killall",cmd);
	}
}

@end
