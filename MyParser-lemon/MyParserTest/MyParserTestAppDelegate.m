//
//  MyParserTestAppDelegate.m
//  MyParserTest
//
//  Created by Edward Patel on 2011-01-26.
//  Copyright 2011 Memention AB. All rights reserved.
//

#import "MyParserTestAppDelegate.h"

#import <MyParser/MyParser.h>

static void result_callback(float value)
{
  ((MyParserTestAppDelegate*)[NSApp delegate]).textFieldOUT.stringValue = [NSString stringWithFormat:@"%f", value];
}

static void error_callback(char *str)
{
  ((MyParserTestAppDelegate*)[NSApp delegate]).textFieldOUT.stringValue = [NSString stringWithFormat:@"%s", str];
}

@implementation MyParserTestAppDelegate

@synthesize window;
@synthesize textFieldIN;
@synthesize textFieldOUT;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)test:(id)sender
{
  NSMutableArray *lines = [NSMutableArray array];
  [lines addObject:@"8127+37283+2348+340+"];
  [lines addObject:@"8127+37283+2348+341+"];
  [lines addObject:@"8127+37283+2348+342"];
  self.textFieldIN.stringValue = [lines componentsJoinedByString:@"\n"];
  MyParser_Parse(lines, result_callback, error_callback);
}

- (void)controlTextDidChange:(NSNotification *)obj
{
    MyParser_Parse(@[self.textFieldIN.stringValue], result_callback, error_callback);
}

@end
