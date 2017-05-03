//
//  XIU_EditorDrawItemView.m
//  图画版
//
//  Created by A-XIU on 2017/5/3.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorDrawItemView.h"
#import "Masonry.h"
@implementation XIU_EditorDrawItemView

-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)img{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _imgView = [[UIImageView alloc] initWithImage:img];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

@end
