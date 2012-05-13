
#import "MouseSettings.h"

@interface MouseSettings ()
@end

#define MOUSE_SETTINGS_ELASTIC_SCROLL @"ElasticScroll"
#define MOUSE_SETTINGS_DEFAULT_STRING @"1"
#define MOUSE_SETTINGS_DEFAULT_INT 1

@implementation MouseSettings

- (void) awakeFromNib {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary * registered = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:MOUSE_SETTINGS_DEFAULT_INT],MOUSE_SETTINGS_ELASTIC_SCROLL,nil];
	[defaults registerDefaults:registered];
	int val = [[defaults objectForKey:MOUSE_SETTINGS_ELASTIC_SCROLL] intValue];
	[_elasticScrollStepper setIntValue:val];
	[_textField setStringValue:[NSString stringWithFormat:@"%i",val]];
}

- (IBAction) onElasticScrollChange:(id) sender {
	int val = [_elasticScrollStepper intValue];
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInt:val] forKey:MOUSE_SETTINGS_ELASTIC_SCROLL];
	[defaults synchronize];
	[_textField setStringValue:[NSString stringWithFormat:@"%i",val]];
	
	pid_t child = fork();
	if(child == 0) {
		char buf[8] = {0};
		snprintf(buf,8,"%i",val);
		char * cmd[] = {"defaults","write","-g","NSScrollViewRubberbanding","-int",buf,(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (IBAction) backToDefaults:(id) sender {
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInt:MOUSE_SETTINGS_DEFAULT_INT]	forKey:MOUSE_SETTINGS_ELASTIC_SCROLL];
	[defaults synchronize];
	[_textField setStringValue:MOUSE_SETTINGS_DEFAULT_STRING];
	
	pid_t child = fork();
	if(child == 0) {
		//defaults delete -g NSScrollViewRubberbanding
		char * cmd[] = {"defaults","delete","-g","NSScrollViewRubberbanding",(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

@end
