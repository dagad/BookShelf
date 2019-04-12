//
//  BookDetailViewController.h
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;

@interface BookDetailViewController : UIViewController

@property (strong, nonatomic) Book *book;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIStackView *pdfStackView;

@property (weak, nonatomic) IBOutlet UIImageView *bookmarkImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *pagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbn10Label;
@property (weak, nonatomic) IBOutlet UILabel *isbn13Label;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIStackView *titleContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *subTitleContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *priceContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *authorContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *publisherContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *pagesContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *yearContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *ratingContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *isbn10ContainerView;
@property (weak, nonatomic) IBOutlet UIStackView *isbn13ContainerView;



@end
