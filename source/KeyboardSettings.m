
#import "KeyboardSettings.h"

extern NSUserDefaults * defaults;

double roundAndTruncate(double value, int precision) {
	if(value == 0) return 0;
	double modifier = pow(10,precision);
	double rounded = (value * modifier + 0.5) / modifier;
	int sined = value > 0 ? 1:-1;
	unsigned int tmp = (rounded * modifier) * sined;
	return (((double)tmp) / modifier * sined);
}

@implementation KeyboardSettings
@synthesize repeat;
@synthesize repeatStep;
@synthesize delay;
@synthesize delayStep;
@synthesize delayValue;
@synthesize repeatValue;

- (void) awakeFromNib {
	NSNumber * rpt = [NSNumber numberWithFloat:1.5];
	NSNumber * del = [NSNumber numberWithFloat:10];
	[defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:rpt,@"Repeat",del,@"Delay",nil]];
	rpt = [defaults objectForKey:@"Repeat"];
	del = [defaults objectForKey:@"Delay"];
	[repeat setFloatValue:[rpt floatValue]];
	[repeatStep setFloatValue:[rpt floatValue]];
	[repeatValue setStringValue:[NSString stringWithFormat:@"%.2f (ms)",[rpt floatValue]]];
	[delay setFloatValue:[del floatValue]];
	[delayStep setFloatValue:[del floatValue]];
	[delayValue setStringValue:[NSString stringWithFormat:@"%.2f (ms)",[del floatValue]]];
}

- (IBAction) defaults:(id) sender {
	NSNumber * rpt = [NSNumber numberWithFloat:1.5];
	NSNumber * del = [NSNumber numberWithFloat:10];
	[repeat setFloatValue:[rpt floatValue]];
	[repeatStep setFloatValue:[rpt floatValue]];
	[repeatValue setStringValue:[NSString stringWithFormat:@"%.2f (ms)",[rpt floatValue]]];
	[delay setFloatValue:[del floatValue]];
	[delayStep setFloatValue:[del floatValue]];
	[delayValue setStringValue:[NSString stringWithFormat:@"%.2f (ms)",[del floatValue]]];
	[self updateDefaultRepeat:1.5];
	[self updateDefaultDelay:10];
}

- (void) updateDefaultRepeat:(float) _repeat {
	[defaults setObject:[NSNumber numberWithFloat:_repeat] forKey:@"Repeat"];
	pid_t child = fork();
	if(child == 0) {
		char buf[25];
		sprintf(buf,"%g",_repeat);
		char * cmd[] = {"defaults","write","NSGlobalDomain","KeyRepeat","-float",buf,(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (void) updateDefaultDelay:(float) _delay {
	[defaults setObject:[NSNumber numberWithFloat:_delay] forKey:@"Delay"];
	pid_t child = fork();
	if(child == 0) {
		char buf[25];
		sprintf(buf,"%g",_delay);
		char * cmd[] = {"defaults","write","NSGlobalDomain","InitialKeyRepeat","-float",buf,(char *)0};
		execvp("/usr/bin/defaults",cmd);
	}
}

- (IBAction) repeatDidUpdate:(id) sender {
	float value = [repeat floatValue];
	value = roundAndTruncate(value,2);
	[repeat setFloatValue:value];
	[repeatStep setFloatValue:value];
	[repeatValue setStringValue:[NSString stringWithFormat:@"%g (ms)",value]];
	[self updateDefaultRepeat:value];
}

- (IBAction) repeatStepDidUpdate:(id) sender {
	float value = [repeatStep floatValue];
	value = roundAndTruncate(value,2);
	[repeat setFloatValue:value];
	[repeatStep setFloatValue:value];
	[repeatValue setStringValue:[NSString stringWithFormat:@"%g (ms)",value]];
	[self updateDefaultRepeat:value];
}

- (IBAction) delayDidUpdate:(id) sender {
	float value = [delay floatValue];
	value = roundAndTruncate(value,2);
	[delayValue setStringValue:[NSString stringWithFormat:@"%g (ms)",value]];
	[delayStep setFloatValue:[delay floatValue]];
	[self updateDefaultDelay:value];
}

- (IBAction) delayStepDidUpdate:(id) sender {
	float value = [delayStep floatValue];
	value = roundAndTruncate(value,2);
	[delay setFloatValue:value];
	[delayStep setFloatValue:value];
	[delayValue setStringValue:[NSString stringWithFormat:@"%g (ms)",value]];
	[self updateDefaultDelay:value];
}

- (void) dealloc {
	[repeat release];
	[delay release];
	[repeatStep release];
	[delayStep release];
	[repeatValue release];
	[delayValue release];
	[super dealloc];
}

@end
