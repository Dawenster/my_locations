//
//  NSMutableString+AddText.m
//  MyLocations
//
//  Created by David Wen on 2013-07-12.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import "NSMutableString+AddText.h"

@implementation NSMutableString (AddText)

- (void)addText:(NSString *)text withSeparator:(NSString *)separator
{
    if (text != nil) {
        if ([self length] > 0) {
            [self appendString:separator];
        }
        [self appendString:text];
    }
}

@end
