//
//  BookCollectionViewCell.h
//  BookShelf
//
//  Created by devdagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;

@interface BookCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;

- (void)configureCellWithBook:(Book *)book;

@end

NS_ASSUME_NONNULL_END
