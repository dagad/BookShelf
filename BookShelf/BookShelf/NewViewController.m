//
//  NewViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "NewViewController.h"
#import "BookShelf-Swift.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BookService.shared requestBookDetailWithIsbn:@"9781617294136" success:^(Book *book) {
        NSLog(@"book received");
    } failure:^(NSError *error) {
        
    }];
    
}

@end
