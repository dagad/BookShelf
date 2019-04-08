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

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    
}

@end
