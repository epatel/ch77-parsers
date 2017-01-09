//
//  MyParserTestAppDelegate.h
//  MyParserTest
//
//  Created by Edward Patel on 2011-01-26.
//  Copyright 2011 Memention AB. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyParserTestAppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate> {
    NSWindow *window;
    NSTextField *textFieldIN;
    NSTextField *textFieldOUT;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textFieldIN;
@property (assign) IBOutlet NSTextField *textFieldOUT;

- (IBAction)test:(id)sender;

@end
