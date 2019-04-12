//
//  NewViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "NewViewController.h"
#import "BookCollectionViewCell.h"
#import "BookDetailViewController.h"
#import "UIAlertController+Error.h"
#import "BookShelf-Swift.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.books = [NSArray array];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    [self reloadBooks];
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];
}

// MARK: - RequestData
- (void)reloadBooks {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared requestNewBooksWithSuccess:^(NSArray<Book *> *books) {
        if(books) {
            weakSelf.books = [NSArray arrayWithArray:books];
            [weakSelf.collectionView setHidden:NO];
            [weakSelf.collectionView reloadData];
        } else {
            [weakSelf.collectionView setHidden:YES];
        }
    } failure:^(NSError *error) {
        [UIAlertController showErrorMessage:BookErrorNetworkFail];
    }];
}

// MARK: - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookcell" forIndexPath:indexPath];
    [cell configureCellWithBook:[self.books objectAtIndex:indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [self.resultCountLabel setText:[self makeFormattedCountString:[self.books count]]];
    return [self.books count];
}

// MARK: - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Book *touchedBook = [self.books objectAtIndex:indexPath.item];
    BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
    [bookDetailVC setBook:touchedBook];
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

// MARK: - UICollectionViewFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = UIScreen.mainScreen.bounds;
    CGSize cellSize = CGSizeMake(screenSize.size.width, 105);
    return cellSize;
}

- (NSString *)makeFormattedCountString:(NSInteger)count {
    NSString *formattedString = [NSString stringWithFormat:@"Total: %ld", count];
    return formattedString;
}

@end
