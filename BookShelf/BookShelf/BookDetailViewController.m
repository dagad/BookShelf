//
//  BookDetailViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookDetailViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "BookShelf-Swift.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)reloadBook:(Book *)book {
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:book.imageSource]];
    [self.titleLabel setText:book.title];
    [self.subTitleLabel setText:book.subtitle];

    [self.authorLabel setText:book.authors];
    [self.publisherLabel setText:book.publisher];
    [self.pagesLabel setText:book.pages];
    [self.yearLabel setText:book.year];
    [self.ratingLabel setText:book.rating];

    [self.priceLabel setText:book.price];
    [self.isbn10Label setText:book.isbn10];
    [self.isbn13Label setText:book.isbn13];

    [self.descriptionLabel setText:book.description];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    [self.navigationController.navigationItem setTitle:self.book.title];
    [self requestBookDetail];
}

- (void)requestBookDetail {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared requestBookDetailWithIsbn:self.book.isbn13 success:^(Book * book) {
        [weakSelf reloadBook: book];
    } failure:^(NSError *error) {
        // Error Handling
    }];
}

@end
