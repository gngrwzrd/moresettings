
#include <signal.h>
#include <strings.h>
#import <PreferencePanes/PreferencePanes.h>
#import "KeyboardSettings.h"
#import "ScreenshotSettings.h"
#import "DockSettings.h"
#import "MouseSettings.h"

@interface MoreSettingsPref : NSPreferencePane {
	int initialy;
	NSWindow * window;
	NSView * container;
	NSPopUpButton * settings;
	NSViewController * selectedController;
	KeyboardSettings * keyboard;
	ScreenshotSettings * screenshots;
	DockSettings * dock;
	MouseSettings * mouse;
}

@property (nonatomic,retain) IBOutlet NSWindow * window;
@property (nonatomic,retain) IBOutlet NSView * container;
@property (nonatomic,retain) IBOutlet NSPopUpButton * settings;

- (void) mainViewDidLoad;
- (IBAction) popupButtonDidChange:(id) sender;
- (IBAction) gngrwzrd:(id) sender;

@end
