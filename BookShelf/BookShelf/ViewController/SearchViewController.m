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
#import "UIAlertController+Error.h"

@interface SearchViewController ()
@property (strong, nonatomic) NSString *keyword;
@property (strong, nonatomic) BookFetcher *fetcher;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidShow:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    self.fetcher.delegate = self;
    self.searchTextField.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];
}

// MARK: - KeyboardEvent
- (void)keyboardWillHide:(NSNotification *)note {
    [self.collectionViewBottomConstraint setConstant:0];
}

- (void)keyboardDidShow:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (@available(iOS 11.0, *)) {
        CGFloat newValue = keyboardSize.height;
        CGFloat safeBottomInset = self.view.safeAreaInsets.bottom;
        [self.collectionViewBottomConstraint setConstant:newValue - safeBottomInset];
    } else {
        CGFloat newValue = keyboardSize.height;
        [self.collectionViewBottomConstraint setConstant:newValue];
    }
}

// MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchProcess];
    return YES;
}

// MARK: - SearchAction
- (IBAction)search:(id)sender {
    [self searchProcess];
}

- (void)searchProcess {
    self.keyword = self.searchTextField.text;
    [self.searchTextField resignFirstResponder];
    [self.fetcher clear];
    self.fetcher.searchKeyword = self.keyword;
    [self.collectionView reloadData];
}

// MARK: - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookcell" forIndexPath:indexPath];
    [cell configureCellWithBook:[self.fetcher bookAtIndexPath:indexPath]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetcher.totalCount;
}

// MARK - UICollectionViewDataSourcePrefetching
- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.fetcher fetchBookWithKeyword:self.keyword searchitemsAt:indexPaths];
}

// MARK: - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Book *touchedBook = [self.fetcher bookAtIndexPath:indexPath];
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

// MARK: - BookFetcherDelegate
- (void)fetcher:(BookFetcher * _Nonnull)fetcher didFetchItemsAt:(NSArray<NSIndexPath *> * _Nonnull)indexPaths {
    [self.collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (void)fetcher:(BookFetcher * _Nonnull)fetcher didUpdateTotalCount:(NSInteger)totalCount {
    [self.collectionView reloadData];
}

- (void)fetcher:(BookFetcher * _Nonnull)fetcher didOccur:(NSError * _Nonnull)error {
    NSLog(@"Fetcher Error: %@", error.description);
}

@end
