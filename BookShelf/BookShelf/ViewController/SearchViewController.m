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
#import "BookShelf-Swift.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

NSInteger currentPage = 0;

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

    self.searchTextField.delegate = self;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];
}

- (void)searchKeyword:(NSString *)keyword page:(NSString *)page {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared searchBooksByKeyword:keyword page:page success:^(NSArray<Book *> *books) {
        weakSelf.books = books;
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        // Error Handling
        [UIAlertController showErrorMessage];
    }];
}
- (IBAction)search:(id)sender {
    NSString *keyword = self.searchTextField.text;
    [self.searchTextField resignFirstResponder];
    [self searchKeyword:keyword page:[@(currentPage) stringValue]];
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
    NSString *keyword = self.searchTextField.text;
    [self.searchTextField resignFirstResponder];
    [self searchKeyword:keyword page:[@(currentPage) stringValue]];
    return YES;
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
