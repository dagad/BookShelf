//
//  NSString+format.m
//  BookShelf
//
//  Created by dagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "NSString+format.h"

@implementation NSString (format)

+ (NSString *)makeFormattedCountString:(NSInteger)count {
    if(count == 0) {
        return nil;
    }
    NSString *formattedString = [NSString stringWithFormat:@"Total: %ld", count];
    return formattedString;
}

@end
