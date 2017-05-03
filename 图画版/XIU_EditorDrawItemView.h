//
//  XIU_EditorDrawItemView.h
//  图画版
//
//  Created by A-XIU on 2017/5/3.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIU_EditorDrawItemView : UIView

-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)img;

@property (nonatomic, strong)UIImageView *imgView;
@end
