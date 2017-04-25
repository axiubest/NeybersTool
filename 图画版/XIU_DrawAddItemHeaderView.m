//
//  XIU_DrawAddItemHeaderView.m
//  图画版
//
//  Created by A-XIU on 2017/4/15.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawAddItemHeaderView.h"
#import "Masonry.h"
@implementation XIU_DrawAddItemHeaderView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, frame.size.height - .5, frame.size.width, .5);
        line.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:line];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.center = self.center;
        label.text = @"SHOP";
        [self addSubview:label];

    }
    return self;
}

@end
