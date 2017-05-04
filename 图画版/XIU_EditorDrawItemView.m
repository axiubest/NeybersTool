//
//  XIU_EditorDrawItemView.m
//  图画版
//
//  Created by A-XIU on 2017/5/3.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorDrawItemView.h"
#import "Masonry.h"


/**默认删除和缩放按钮的大小*/
#define btnW_H 24.0
/**默认的图片宽高*/
#define defaultImageViewW_H self.frame.size.width - btnW_H
/**缩放和删除按钮与图片的间隔距离*/
#define paster_insert_space btnW_H/2
/**总高度*/
#define PASTER_SLIDE 120
/**安全边框*/
#define SECURITY_LENGTH PASTER_SLIDE/2
@interface XIU_EditorDrawItemView ()
{
    CGPoint prevPoint;
    CGFloat minWidth;
    CGFloat minHeight;
    CGFloat deltaAngle;
}
@property (nonatomic, strong) UIImageView *scaleImageView;
@property (nonatomic, weak) UIImageView *rotateImageView;

@end

@implementation XIU_EditorDrawItemView



-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)img{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 2.f;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        minWidth = self.bounds.size.width * 0.5;
        minHeight = self.bounds.size.height * 0.5;
        deltaAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y, self.frame.origin.x+self.frame.size.width - self.center.x);
        
        self.backgroundColor = [UIColor clearColor];
        _imgView = [[UIImageView alloc] initWithImage:img];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        UIImageView *rotateImageView = [[UIImageView alloc]init];
        [rotateImageView setImage:[UIImage imageNamed:@"bt_paster_transform"]];
        rotateImageView.backgroundColor = [UIColor orangeColor];
        UIPanGestureRecognizer *rotatePanResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateResizeTranslate:)] ;
        rotateImageView.userInteractionEnabled = YES;
        [rotateImageView addGestureRecognizer:rotatePanResizeGesture] ;
        [self addSubview:rotateImageView];
        _rotateImageView = rotateImageView;
        self.rotateImageView.frame = CGRectMake(self.bounds.size.width - 10,0,20,20);
        
        
        UIImageView *scaleImageView = [[UIImageView alloc]init];
        [scaleImageView setImage:[UIImage imageNamed:@"bt_paster_transform"]];
        scaleImageView.backgroundColor = [UIColor orangeColor];
        UIPanGestureRecognizer *scalePanResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)] ;
        scaleImageView.userInteractionEnabled = YES;
        [scaleImageView addGestureRecognizer:scalePanResizeGesture] ;
        [self addSubview:scaleImageView];
        self.scaleImageView = scaleImageView;
        

        self.scaleImageView.frame = CGRectMake(self.bounds.size.width - 10,self.bounds.size.height - 10,20,20);

    }
    return self;
}



//旋转
- (void)rotateResizeTranslate:(UIPanGestureRecognizer *)recognizer {
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }else {
        /* 旋转 */
        float ang = atan2([recognizer locationInView:self.superview].y - self.center.y, [recognizer locationInView:self.superview].x - self.center.x) ;
        float angleDiff = deltaAngle - ang ;
        self.transform = CGAffineTransformMakeRotation(-angleDiff);
        [self setNeedsDisplay];
    }
}
/**
 *  右下角的缩放
 */
- (void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (self.bounds.size.width < minWidth || self.bounds.size.height < minHeight)
        {
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, minWidth + 1 , minHeight + 1);
            self.rotateImageView.frame = CGRectMake(self.bounds.size.width - 10,0,20,20);
            self.scaleImageView.frame = CGRectMake(self.bounds.size.width - 10,self.bounds.size.height - 10,20,20);

            prevPoint = [recognizer locationInView:self];
        }
        else
        {
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            wChange = (point.x - prevPoint.x);
            float wRatioChange = (wChange/(float)self.bounds.size.width);
            hChange = wRatioChange * self.bounds.size.height;
            
            if (ABS(wChange) > 50.0f || ABS(hChange) > 50.0f)
            {
                prevPoint = [recognizer locationOfTouch:0 inView:self];
                return;
            }
            
            CGFloat finalWidth  = self.bounds.size.width + (wChange) ;
            CGFloat finalHeight = self.bounds.size.height + (wChange) ;
            if (finalWidth > PASTER_SLIDE*(1+0.5))
            {
                finalWidth = PASTER_SLIDE*(1+0.5);
            }
            if (finalWidth < PASTER_SLIDE*(1-0.5))
            {
                finalWidth = PASTER_SLIDE*(1-0.5) ;
            }
            if (finalHeight > PASTER_SLIDE*(1+0.5))
            {
                finalHeight = PASTER_SLIDE*(1+0.5) ;
            }
            if (finalHeight < PASTER_SLIDE*(1-0.5))
            {
                finalHeight = PASTER_SLIDE*(1-0.5) ;
            }
            
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, finalWidth, finalHeight);
            self.scaleImageView.frame = CGRectMake(self.bounds.size.width - 10,self.bounds.size.height - 10,20,20);
        self.rotateImageView.frame = CGRectMake(self.bounds.size.width - 10,0,20,20);

            
            prevPoint = [recognizer locationOfTouch:0 inView:self];
        }
        

        
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    
    //检查旋转和缩放是否出界
//    [self checkIsOut];
}

@end
