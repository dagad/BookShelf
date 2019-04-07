//
//  SearchViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "SearchViewController.h"
#import "BookShelf-Swift.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BookService.shared searchBooksByKeyword:@"mongodb" page:@"0" success:^(NSArray *books) {
        NSLog(@"received search result");
    } failure:^(NSError *error) {
        
    }];
    
}

@end
