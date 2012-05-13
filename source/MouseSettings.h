
#import <Cocoa/Cocoa.h>

@interface MouseSettings : NSViewController {
	IBOutlet NSStepper * _elasticScrollStepper;
	IBOutlet NSTextField * _textField;
}

- (IBAction) onElasticScrollChange:(id)sender;

@end
