//
//  HistoryViewController.h
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookCollectionViewCellDelegate;

@interface HistoryViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, BookCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *books;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

