//
//  UIAlertController+Error.m
//  BookShelf
//
//  Created by Sangyeol Kang on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "UIAlertController+Error.h"

@implementation UIAlertController (Error)

+(void)showErrorMessage:(BookErrorType)error {
    NSString *errorMessage = [BookError getErrorMessage:error];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"okay" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:action];
    UIViewController *rootVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    if(rootVC) {
        [rootVC presentViewController:alertVC animated:YES completion:nil];
    }
}

@end
