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





-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(20 * 40, 60);
        
        [self addSubview:scrollView];
        for (int i = 0; i < 11; i++) {
            XIU_EditorBotton *edit = [[XIU_EditorBotton alloc] initWithFrame:CGRectMake(i * 40, 0, 60, 60) ImageName:[NSString stringWithFormat:@"%d", i] Title:@"2"];
            edit.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clcikBotton:)];
            [edit addGestureRecognizer:tap];
            [scrollView addSubview:edit];

        
        [self addSubview:self.scrollView];
        }
    }
    return self;

}

- (void)clcikBotton:(UIView *)view {
    switch (view.tag) {
        case EditorToolStyle_Clone:
            if ([self.delegate respondsToSelector:@selector(editorToolClone)]) {
                [self.delegate editorToolClone];
            }
            break;
        case EditorToolStyle_Delete:
            if ([self.delegate respondsToSelector:@selector(editorToolDelete)]) {
                [self.delegate editorToolDelete];
                break;
            case EditorToolStyle_Filter:
                if ([self.delegate respondsToSelector:@selector(editorToolFilter)]) {
                    [self.delegate editorToolFilter];
                break;
            case EditorToolStyle_Lock:
                
                break;
            case EditorToolStyle_Info:
                
                break;
            case EditorToolStyle_Perspecitive:
                
                break;
            case EditorToolStyle_Flip:
                
                break;
            default:
                break;
            }
    }


}
}
@end

#pragma mark BottonView
@implementation XIU_EditorBotton

-(instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)iamgeName Title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bg = [[UIView alloc] initWithFrame:frame];
        [self addSubview:bg];
        bg.backgroundColor = [UIColor clearColor];
        bg.layer.borderWidth = .5f;
        bg.layer.borderColor = [UIColor grayColor].CGColor;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(17, 10, 24, 30)];
        img.image = [UIImage imageNamed:iamgeName];
        [bg addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.size.height + 10, img.frame.size.width, frame.size.height * 0.2)];
        label.textAlignment = 1;
        label.textColor = [UIColor darkGrayColor];
        label.text = title;
        
        [bg addSubview:label];

    }
    return self;
    }


@end
