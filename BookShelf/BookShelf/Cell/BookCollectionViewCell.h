//
//  BookCollectionViewCell.h
//  BookShelf
//
//  Created by devdagad on 08/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;

@protocol BookCollectionViewCellDelegate;

@interface BookCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) id<BookCollectionViewCellDelegate> delgate;
- (void)configureCellWithBook:(Book *)book;
- (void)setBookCellHidden:(BOOL)hidden;

@end

@protocol BookCollectionViewCellDelegate <NSObject>
- (void)bookCollectionViewCellDidDelete:(BookCollectionViewCell *)cell;
@end
