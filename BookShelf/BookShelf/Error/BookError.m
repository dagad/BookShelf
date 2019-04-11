//
//  BookError.m
//  BookShelf
//
//  Created by devdagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookError.h"

@implementation BookError

+ (NSString *)getErrorMessage:(BookErrorType)error {
    switch (error) {
        case BookErrorNetworkFail:
            return @"Please try again later";
    }
}

@end
