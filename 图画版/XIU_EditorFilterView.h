//
//  XIU_EditorFilterView.h
//  图画版
//
//  Created by A-XIU on 2017/5/3.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_EditorFilterDelgate <NSObject>

@required
- (void)filterValueChangeOfHorizontalWithValue:(CGFloat)value;
- (void)filterValueChangeOfVerticalWithValue:(CGFloat)value;


@end
@interface XIU_EditorFilterView : UIView
@property (nonatomic,assign)id<XIU_EditorFilterDelgate> delegate;

@end
