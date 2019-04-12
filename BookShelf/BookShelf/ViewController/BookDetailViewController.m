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

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBookmark)];
    [self.bookmarkImageView addGestureRecognizer:gesture];

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
    [self.scrollView setHidden:YES];
}

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

    [self addPdfView:book];
}

- (void)addPdfView:(Book *)book {
    NSDictionary *pdfDatas = book.pdf;
    if([[pdfDatas allKeys] count] > 0) {
        [self.pdfStackView setHidden:NO];
        for(NSString *key in [pdfDatas allKeys]) {
            UIButton *pdfButton = [[UIButton alloc] init];
            UILabel *pdfLabel = [[UILabel alloc] init];
            NSString *pdfLink = [pdfDatas objectForKey:key];
            [pdfButton setAttributedTitle:[self createHiperLink:pdfLink] forState:UIControlStateNormal];
            [pdfButton addTarget:self action:@selector(openPdfLink:) forControlEvents:UIControlEventTouchUpInside];
            [pdfLabel setAttributedText:[self createHiperLink:pdfLink]];
            [self.pdfStackView addArrangedSubview:pdfButton];
        }
    } else {
        [self.pdfStackView setHidden:YES];
    }
}

- (NSAttributedString *)createHiperLink:(NSString *)string {
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                 NSUnderlineColorAttributeName: [UIColor blueColor],
                                 NSForegroundColorAttributeName: [UIColor blueColor]};
    return [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

- (void)openPdfLink:(UIButton *)button {
    NSString *link = button.titleLabel.text;
    NSURL *url = [NSURL URLWithString:link];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly: @NO};
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
    }

}

- (void)requestBookDetail {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared requestBookDetailWithIsbn:self.book.isbn13 success:^(Book * book) {
        [[HistoryContainer shared] addBook:book];
        [weakSelf setBookData: book];
        [self.scrollView setHidden:NO];
    } failure:^(NSError *error) {
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
