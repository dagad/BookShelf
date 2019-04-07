//
//  NewViewController.m
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "NewViewController.h"
#import "BookCollectionViewCell.h"
#import "BookShelf-Swift.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.books = [NSArray array];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bookcell"];
    
    [self reloadBooks];
}

// MARK: - RequestData
- (void)reloadBooks {
    __weak __typeof(self) weakSelf = self;
    [BookService.shared requestNewBooksWithSuccess:^(NSArray<Book *> *books) {
        weakSelf.books = [NSArray arrayWithArray:books];
        [weakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        // Error Handling
    }];
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

// MARK: - UICollectionViewFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenSize = UIScreen.mainScreen.bounds;
    CGSize cellSize = CGSizeMake(screenSize.size.width, 105);
    return cellSize;
}

@end
