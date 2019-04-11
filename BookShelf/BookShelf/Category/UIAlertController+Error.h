//
//  UIAlertController+Error.h
//  BookShelf
//
//  Created by Sangyeol Kang on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookError.h"

@interface UIAlertController (Error)

+(void)showErrorMessage:(BookErrorType)error;

@end
