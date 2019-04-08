//
//  SearchViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "SearchViewController.h"
#import "BookDetailViewController.h"
#import "BookCollectionViewCell.h"
#import "BookShelf-Swift.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

NSInteger currentPage = 0;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];

    self.searchBar.delegate = self;
}

- (void)searchKeyword:(NSString *)keyword page:(NSString *)page {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared searchBooksByKeyword:keyword page:page success:^(NSArray<Book *> *books) {
        weakSelf.books = books;
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        // Error Handling
    }];
}
- (IBAction)search:(id)sender {
    NSString *keyword = self.searchBar.text;
    [self searchKeyword:keyword page:[@(currentPage) stringValue]];
}


// MARK: - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {

}

// MARK: - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookcell" forIndexPath:indexPath];
    [cell configureCellWithBook:[self.books objectAtIndex:indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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



@end
