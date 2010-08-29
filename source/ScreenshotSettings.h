
#import <Cocoa/Cocoa.h>
#import "MoreSettingsExterns.h"
#include <sys/stat.h>

@interface ScreenshotSettings : NSViewController <NSOpenSavePanelDelegate> {
	NSButton * choose;
	NSTextField * location;
}

@property (nonatomic,retain) IBOutlet NSButton * choose;
@property (nonatomic,retain) IBOutlet NSTextField * location;

- (void) setScreenshotLocation:(NSString *) loc;
- (IBAction) chooseLocation:(id) sender;
- (IBAction) defaults:(id) sender;

@end
