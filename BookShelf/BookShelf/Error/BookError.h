//
//  BookError.h
//  BookShelf
//
//  Created by devdagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BookErrorType) {
    BookErrorNetworkFail
};

@interface BookError : NSObject

+ (NSString *)getErrorMessage:(BookErrorType)error;

@end

