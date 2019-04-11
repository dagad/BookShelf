//
//  BookDetailViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookmarkContainer.h"
#import "HistoryContainer.h"
#import "UIAlertController+Error.h"
#import <SDWebImage/SDWebImage.h>
#import "BookShelf-Swift.h"

@interface BookDetailViewController ()

@property (nonatomic) BOOL isBookmarked;

@end

@implementation BookDetailViewController

- (void)setBookData:(Book *)book {
    self.book = book;
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

    [self.descriptionLabel setText:book.desc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBookmark)];
    [self.bookmarkImageView addGestureRecognizer:gesture];
    [self.bookmarkImageView setHidden:YES];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }

    [self setTitle:@"Detail"];
    [self requestBookDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isBookmarked = [[BookmarkContainer shared] isRegistered:self.book];
    [self setBookmarkIcon:self.isBookmarked];
}

- (void)requestBookDetail {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared requestBookDetailWithIsbn:self.book.isbn13 success:^(Book * book) {
        [[HistoryContainer shared] addBook:book];
        [weakSelf setBookData: book];
        [weakSelf.bookmarkImageView setHidden:NO];
    } failure:^(NSError *error) {
        // Error Handling
        [UIAlertController showErrorMessage:BookErrorNetworkFail];
    }];
}

- (void)toggleBookmark {
    if(self.isBookmarked) {
        [[BookmarkContainer shared] unRegisterBook:[self.book copy]];
    } else {
        [[BookmarkContainer shared] registerBook:[self.book copy]];
    }
    self.isBookmarked = !self.isBookmarked;
    [self setBookmarkIcon:self.isBookmarked];
}

- (void)setBookmarkIcon:(BOOL)isMarked {
    if(isMarked) {
        [self.bookmarkImageView setImage:[UIImage imageNamed:@"like"]];
    } else {
        [self.bookmarkImageView setImage:[UIImage imageNamed:@"unlike"]];
    }
}

@end
