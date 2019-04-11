//
//  BookmarkViewController.h
//  BookShelf
//
//  Created by dagad on 05/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollectionViewCell.h"

@interface BookmarkViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, BookCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *books;

@end
