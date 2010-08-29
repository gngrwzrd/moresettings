
#import <Cocoa/Cocoa.h>
//#import "MoreSettingsExterns.h"
#include <unistd.h>
#include <stdio.h>
#include <string.h>

@interface KeyboardSettings : NSViewController {
	NSSlider * repeat;
	NSSlider * delay;
	NSStepper * repeatStep;
	NSStepper * delayStep;
	NSTextField * repeatValue;
	NSTextField * delayValue;
}

@property (nonatomic,retain) IBOutlet NSSlider * repeat;
@property (nonatomic,retain) IBOutlet NSSlider * delay;
@property (nonatomic,retain) IBOutlet NSStepper * repeatStep;
@property (nonatomic,retain) IBOutlet NSStepper * delayStep;
@property (nonatomic,retain) IBOutlet NSTextField * repeatValue;
@property (nonatomic,retain) IBOutlet NSTextField * delayValue;

- (void) updateDefaultRepeat:(float) _repeat;
- (void) updateDefaultDelay:(float) _delay;
- (IBAction) defaults:(id) sender;
- (IBAction) repeatDidUpdate:(id) sender;
- (IBAction) repeatStepDidUpdate:(id) sender;
- (IBAction) delayDidUpdate:(id) sender;
- (IBAction) delayStepDidUpdate:(id) sender;

@end
