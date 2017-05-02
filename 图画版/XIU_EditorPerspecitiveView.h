//
//  XIU_EditorPerspecitiveView.h
//  图画版
//
//  Created by A-XIU on 2017/4/26.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_EditorPerspecitiveDelgate <NSObject>

@required
- (void)perspecitiveValueChangeOfHorizontalWithValue:(CGFloat)value;
- (void)perspecitiveValueChangeOfVerticalWithValue:(CGFloat)value;
- (void)perspecitiveSureDeleagete;
- (void)perspecitiveChancelDeleagete;

@end

@interface XIU_EditorPerspecitiveView : UIView
@property (nonatomic,assign)id<XIU_EditorPerspecitiveDelgate> delegate;
- (void)hiddenEditorPersperitiveWithAnimation:(BOOL)animation;
//- (void)showEditorPersperitiveWithAnimation:(BOOL)animation;

@end
