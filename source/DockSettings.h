
#import <Cocoa/Cocoa.h>

@interface DockSettings : NSViewController {
	IBOutlet NSStepper * _delayStepper;
	IBOutlet NSTextField * _delayField;
}

- (IBAction) defaults:(id) sender;
- (IBAction) onDelayStepperChange:(id)sender;
- (void) updateDockShowDelay:(float) delay;

@end
