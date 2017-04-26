//
//  XIU_EditorToolView.m
//  图画版
//
//  Created by A-XIU on 2017/4/9.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorToolView.h"

@interface XIU_EditorToolView ()<UIScrollViewDelegate>


@property (nonatomic, weak)UIScrollView *scrollView;


@end

@implementation XIU_EditorToolView
@synthesize style = _style;


-(XIU_EditorPerspecitiveView *)perspecitive {
    if (!_perspecitive) {
        XIU_EditorPerspecitiveView *perspecitive = [[[NSBundle mainBundle] loadNibNamed:@"XIU_EditorPerspecitiveView" owner:nil options:nil] firstObject];
        perspecitive.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 180);
        _perspecitive = perspecitive;
    }
    return _perspecitive;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        _scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(20 * 40, 60);
        
        [self addSubview:scrollView];

        for (int i = 0; i < 11; i++) {
            UIButton *edit = [[UIButton alloc] initWithFrame:CGRectMake(i * 40, 0, 60, 60)];
            edit.backgroundColor = [UIColor grayColor];
            [edit setTitle:@"1" forState:UIControlStateNormal];
            edit.tag = i;
            [edit addTarget:self action:@selector(clcikBotton:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:edit];
            [self.scrollView addSubview:edit];
        }

        [self createToolBarView];

    }
    return self;

}

- (void)createToolBarView {
       [self addSubview:self.perspecitive];
}

- (void)clcikBotton:(UIButton *)sender {
    switch (sender.tag) {
        case EditorToolStyle_Clone:
//            if ([self.delegate respondsToSelector:@selector(editorToolClone)]) {
//                [self.delegate editorToolClone];
//            }
            _style = EditorToolStyle_Clone;
            break;
        case EditorToolStyle_Delete:
     
                break;
            case EditorToolStyle_Filter:
                        break;
            case EditorToolStyle_Lock:
                
                break;
            case EditorToolStyle_Info:
                
                break;
                case EditorToolStyle_Perspecitive:{
                    [UIView animateWithDuration:.5 animations:^{
                        self.perspecitive.frame = CGRectMake(0, self.frame.size.height - 170, self.frame.size.width, 170);
                    }];
                    
                }
                       break;
            case EditorToolStyle_Flip:
                
                break;
            default:
                break;
            }
    
    NSDictionary *dic = @{@"type":[NSNumber numberWithInteger:sender.tag]};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:dic];
}
@end
