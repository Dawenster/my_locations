//
//  NSMutableString+AddText.h
//  MyLocations
//
//  Created by David Wen on 2013-07-12.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (AddText)

- (void)addText:(NSString *)text withSeparator:(NSString *)separator;

@end
