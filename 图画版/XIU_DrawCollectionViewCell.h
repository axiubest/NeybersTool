//
//  XIU_DrawCollectionViewCell.h
//  图画版
//
//  Created by A-XIU on 2017/4/15.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_DrawCollectionViewCellDelegate <NSObject>

- (void)clcikAddBtnDelegate;
- (void)clcikImageViewDelegate;
@end

@interface XIU_DrawCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<XIU_DrawCollectionViewCellDelegate> Delegate;

@end
