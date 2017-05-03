//
//  XIU_EditorPerspecitiveView.m
//  图画版
//
//  Created by A-XIU on 2017/4/26.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorPerspecitiveView.h"

@interface XIU_EditorPerspecitiveView ()

@property (weak, nonatomic) IBOutlet UISlider *horizontalTransformSlider;

@property (weak, nonatomic) IBOutlet UISlider *verticalTransformSlider;

@end

@implementation XIU_EditorPerspecitiveView



- (void)hiddenEditorPersperitiveWithAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:.5f animations:^{
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180);
        }];

    }else {
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180);
          }
}

- (IBAction)clickChanel:(id)sender {
    [self hiddenEditorPersperitiveWithAnimation:YES];
}

- (IBAction)clickSure:(id)sender {
    [self hiddenEditorPersperitiveWithAnimation:YES];

}

- (IBAction)horizontalSliderValueChange:(UISlider *)sender {
    [_delegate perspecitiveValueChangeOfHorizontalWithValue:sender.value];
}
- (IBAction)verticalSliderValueChange:(UISlider *)sender {
    [_delegate perspecitiveValueChangeOfVerticalWithValue:sender.value];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    _horizontalTransformSlider.continuous = YES;
    _verticalTransformSlider.continuous = YES;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
