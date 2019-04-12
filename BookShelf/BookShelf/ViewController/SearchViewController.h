//
//  SearchViewController.h
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookFetcherDelegate;

@interface SearchViewController : UIViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, BookFetcherDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewBottomConstraint;

@end
