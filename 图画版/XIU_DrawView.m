//
//  XIU_DrawView.m
//  图画版
//
//  Created by A-XIU on 2017/4/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawView.h"
#import "WBGImageEditorGestureManager.h"
#import "TOCropViewController.h"
@interface XIU_DrawView ()<UIGestureRecognizerDelegate,TOCropViewControllerDelegate>
{
    CGFloat _rotation;
    UIViewController *editorController;
    UIImageView *tmpimg;

}
@property (nonatomic, weak) UIImageView *archerBGView;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageView2;
@property CGFloat lastRotation;
@property CGRect frame1;
@property CGRect frame2;

@end
static UIView *activeView = nil;

@implementation XIU_DrawView


+ (void)setActiveTextView:(UIView *)view
{
    if(view != activeView){
//        [activeView setAvtive:NO];
        activeView = view;
//        [activeView setAvtive:YES];
        
        [activeView.superview bringSubviewToFront:activeView];
        
    }
}

-(void)createNewViewWithImage:(UIImage *)newImage {
    if (newImage == nil) {
        return;
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:newImage];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    _archerBGView = imgView;
    imgView.frame = CGRectMake(120, 120, 200, 200);
    imgView.center = self.center;
    [self initGesturesWithView:imgView];

    
}


- (void)initGesturesWithView:(UIImageView *)imageView;
{
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPan:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidPinch:)];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidRotation:)];
    
    [pinch requireGestureRecognizerToFail:tap];
    [rotation requireGestureRecognizerToFail:tap];
    
//    [self.textTool.editor.scrollView.panGestureRecognizer requireGestureRecognizerToFail:pan];
    
    tap.delegate = [WBGImageEditorGestureManager instance];
    pan.delegate = [WBGImageEditorGestureManager instance];
    pinch.delegate = [WBGImageEditorGestureManager instance];
    rotation.delegate = [WBGImageEditorGestureManager instance];
    
    [imageView addGestureRecognizer:tap];
    [imageView addGestureRecognizer:pan];
    [imageView addGestureRecognizer:pinch];
    [imageView addGestureRecognizer:rotation];
}

- (void)viewDidTap:(UITapGestureRecognizer*)sender
{
    NSLog(@"%@---", sender.view);
    tmpimg = (UIImageView *)sender.view;

    if (sender.state == UIGestureRecognizerStateEnded) {
//        if(self.active){
//            [self editTextAgain:sender];
//        } else {
//            //取消当前
////            [self.textTool.editor resetCurrentTool];
//        }
        [[self class] setActiveTextView:sender.view];
//        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
        
    }
}


- (void)viewDidPan:(UIPanGestureRecognizer*)recognizer
{
    //平移
    tmpimg = (UIImageView *)recognizer.view;
//    [[self class] setActiveTextView:self];
    UIView *piece = recognizer.view;
    CGPoint translation = [recognizer translationInView:piece.superview];
    piece.center = CGPointMake(piece.center.x + translation.x, piece.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:piece.superview];
    
    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
//        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
//        [self.textTool.editor resetCurrentTool];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        
//        CGRect rectCoordinate = [piece.superview convertRect:piece.frame toView:self.textTool.editor.imageView.superview];
//        if (!CGRectIntersectsRect(CGRectInset(self.textTool.editor.imageView.frame, 30, 30), rectCoordinate)) {
//            [UIView animateWithDuration:.2f animations:^{
//                piece.center = piece.superview.center;
//                self.center = piece.center;
//                
//            }];
//        }
        
//        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
    [self layoutSubviews];
}

- (void)viewDidPinch:(UIPinchGestureRecognizer *)recognizer {
    //缩放
//    [[self class] setActiveTextView:self];
    tmpimg = (UIImageView *)recognizer.view;

    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        //坑点：recognizer.scale是相对原图片大小的scal
        
        CGFloat scale = [(NSNumber *)[recognizer.view valueForKeyPath:@"layer.transform.scale.x"] floatValue];
        NSLog(@"scale = %f", scale);
        
//        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
//        [self.textTool.editor resetCurrentTool];
        
        CGFloat currentScale = recognizer.scale;
        
//        if (scale > MAX_TEXT_SCAL && currentScale > 1) {
//            return;
//        }
//        
//        if (scale < MIN_TEXT_SCAL && currentScale < 1) {
//            return;
//        }
        
        
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, currentScale, currentScale);
        recognizer.scale = 1;
        [self layoutSubviews];
        
//        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
//        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
}

- (void)viewDidRotation:(UIRotationGestureRecognizer *)recognizer {
    //旋转
    tmpimg = (UIImageView *)recognizer.view;

    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        
        recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
        _rotation = _rotation + recognizer.rotation;
        recognizer.rotation = 0;
        [self layoutSubviews];
        
//        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
//        [self.textTool.editor resetCurrentTool];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateFailed ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
//        [self.textTool.editor hiddenTopAndBottomBar:NO animation:YES];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGRect boundss;
//    if (!_archerBGView.superview) {
//        [self.superview insertSubview:_archerBGView belowSubview:self];
//        _archerBGView.frame = self.frame;
//        boundss = self.bounds;
//    }
//    boundss = _archerBGView.bounds;
//    self.transform = CGAffineTransformMakeRotation(_rotation);
//    
//    CGFloat w = boundss.size.width;
//    CGFloat h = boundss.size.height;
//    CGFloat scale = [(NSNumber *)[_archerBGView valueForKeyPath:@"layer.transform.scale.x"] floatValue];
//    
//    self.bounds = CGRectMake(0, 0, w*scale, h*scale);
//    self.center = _archerBGView.center;
//    
//    _archerBGView.frame = CGRectMake(0 , 0, self.bounds.size.width - 2*15, self.bounds.size.height - 2*15);
 
}



-(instancetype)initWithFrame:(CGRect)frame Controller:(UIViewController *)controller {
    self = [super initWithFrame:frame];
    if(self) {
        editorController = controller;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toolBarCommunication:) name:@"texttext" object:nil];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        img.center = self.center;
        img.userInteractionEnabled = YES;
        img.image = [UIImage imageNamed:@"timg.jpeg"];
        [self addSubview:img];


    }
    return self;
}


- (void)toolBarCommunication:(NSNotification *)noti {
    NSLog(@"%@", noti);
    if ([noti.userInfo[@"type"] isEqual:[NSNumber numberWithInteger:7]]) {
        TOCropViewController * cropViewController = [[TOCropViewController alloc ] initWithImage: tmpimg.image];
        cropViewController.delegate = self;
        [ editorController  presentViewController: cropViewController animated:YES  completion:nil ];
    }
    
    if ([noti.userInfo[@"type"] isEqual:@4]) {
        CATransform3D trans = CATransform3DIdentity;
        NSInteger num = [noti.userInfo[@"value"] integerValue];
        trans.m34 = -(num/100);
        trans = CATransform3DRotate(trans, M_PI/4, 0, 1, 0);
        _imageView.layer.transform = trans;
        _imageView2.layer.transform = trans;

    }
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    
}
@end
