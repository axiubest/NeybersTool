//
//  XIU_EditorToolView.h
//  图画版
//
//  Created by A-XIU on 2017/4/9.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XIU_EditorPerspecitiveView.h"
#import "XIU_EditorFilterView.h"
typedef NS_ENUM (NSUInteger, EditorToolStyle) {
    EditorToolStyle_Delete,
    EditorToolStyle_Forward,
    EditorToolStyle_Back,
    EditorToolStyle_Flip,
    EditorToolStyle_Clone,
    EditorToolStyle_Filter,
    EditorToolStyle_Crop,//剪裁
    EditorToolStyle_Perspecitive,
    EditorToolStyle_Lock,
    EditorToolStyle_Info
  
};

@protocol XIU_EditorToolDelegate <NSObject>

@required
- (void)editorToolClone;
- (void)editorToolDelete;
- (void)editorToolFilter;
- (void)editorToolLock;
- (void)editorToolInfo;
- (void)editorToolPerspecitive;
- (void)editorToolFlip;

@end
@interface XIU_EditorToolView : UIView

-(instancetype)initWithFrame:(CGRect)frame Controller:(UIViewController *)controller;

@property (nonatomic, assign)id<XIU_EditorToolDelegate> delegate;

@property (nonatomic, assign) EditorToolStyle style;

@property (nonatomic, weak)XIU_EditorPerspecitiveView *perspecitive;
@property (nonatomic, weak)XIU_EditorFilterView *filter;
@end



