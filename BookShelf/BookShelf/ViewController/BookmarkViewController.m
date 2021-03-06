//
//  BookmarkViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookmarkViewController.h"
#import "BookCollectionViewCell.h"
#import "BookDetailViewController.h"
#import "BookmarkContainer.h"
#import "NSString+format.h"
#import "BookShelf-Swift.h"

@interface BookmarkViewController ()

@end

@implementation BookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadCollectionView];
}

- (void)reloadCollectionView {
    self.books = [[BookmarkContainer shared] getMarkedBooks];
    [self.collectionView reloadData];
}

-(void)setBooks:(NSArray *)books {
    _books = books;
    if ([books count] == 0) {
        [self.collectionView setHidden:YES];
    } else {
        [self.collectionView setHidden:NO];
    }
}

// MARK: - Edit
- (void)deleteBookAtIndexPath:(NSIndexPath *)indexPath {
    Book *book = [self.books objectAtIndex:indexPath.row];
    [[BookmarkContainer shared] unRegisterBook:[book copy]];
    self.books = [[BookmarkContainer shared] getMarkedBooks];
}

// MARK: - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookcell" forIndexPath:indexPath];
    cell.delgate = self;
    [cell setBookCellHidden:NO];
    [cell configureCellWithBook:[self.books objectAtIndex:indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [self.resultCountLabel setText:[NSString makeFormattedCountString:[self.books count]]];
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

// MARK: - BookCollectionViewCellDelegate
- (void)bookCollectionViewCellDidDelete:(BookCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self deleteBookAtIndexPath:indexPath];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
