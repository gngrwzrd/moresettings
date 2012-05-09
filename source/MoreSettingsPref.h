
#import <PreferencePanes/PreferencePanes.h>
#import "KeyboardSettings.h"
#import "ScreenshotSettings.h"
#import "DockSettings.h"

@interface MoreSettingsPref : NSPreferencePane {
	int initialy;
	NSWindow * window;
	NSView * container;
	NSPopUpButton * settings;
	NSViewController * selectedController;
	NSViewController * keyboard;
	NSViewController * screenshots;
	NSViewController * dock;
}

@property (nonatomic,retain) IBOutlet NSWindow * window;
@property (nonatomic,retain) IBOutlet NSView * container;
@property (nonatomic,retain) IBOutlet NSPopUpButton * settings;

- (void) mainViewDidLoad;
- (IBAction) popupButtonDidChange:(id) sender;
- (IBAction) gngrwzrd:(id) sender;

@end
