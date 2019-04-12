//
//  BookCollectionViewCellDelegate.h
//  BookShelf
//
//  Created by dagad on 12/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

@class BookCollectionViewCell;

@protocol BookCollectionViewCellDelegate <NSObject>
- (void)bookCollectionViewCellDidDelete:(BookCollectionViewCell *)cell;
@end
