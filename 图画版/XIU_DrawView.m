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
#import "Masonry.h"
#import "XIU_EditorDrawItemView.h"
#import <CoreImage/CoreImage.h>
#define MAX_SCAL 400
#define MIN_SCAL 20


@interface XIU_DrawView ()<UIGestureRecognizerDelegate,TOCropViewControllerDelegate>
{
    CGFloat _rotation;
    UIViewController *editorController;
    XIU_EditorDrawItemView *tmpimg;



}
@property (nonatomic, weak) UIImageView *archerBGView;

@property CGFloat lastRotation;


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
    XIU_EditorDrawItemView *view = [[XIU_EditorDrawItemView alloc] initWithFrame:CGRectMake(120, 120, 200, 200) Image:newImage];
    tmpimg = view;
    [self addSubview:view];
    
    [self initGesturesWithView:view];

}


- (void)initGesturesWithView:(UIView *)imageView;
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
    tmpimg = (XIU_EditorDrawItemView *)sender.view;

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
    tmpimg = (XIU_EditorDrawItemView *)recognizer.view;
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
    tmpimg = (XIU_EditorDrawItemView *)recognizer.view;

    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        //坑点：recognizer.scale是相对原图片大小的scal
        
        CGFloat scale = [(NSNumber *)[recognizer.view valueForKeyPath:@"layer.transform.scale.x"] floatValue];
        NSLog(@"scale = %f", scale);
        
//        [self.textTool.editor hiddenTopAndBottomBar:YES animation:YES];
        //取消当前
//        [self.textTool.editor resetCurrentTool];
        
        CGFloat currentScale = recognizer.scale;
        
        if (scale > MAX_SCAL && currentScale > 1) {
            return;
        }
        
        if (scale < MIN_SCAL && currentScale < 1) {
            return;
        }
        
        
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
    tmpimg = (XIU_EditorDrawItemView *)recognizer.view;

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
    
    if (!tmpimg) {
        return;
    }
        if ([noti.userInfo[@"type"] isEqual:[NSNumber numberWithInteger:5]])  {//filter
        NSInteger num = [noti.userInfo[@"value"] integerValue];
            
            
            
            CIContext *context = [CIContext contextWithOptions:nil];
            CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"char"]];
            // create gaussian blur filter
            CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
            [filter setValue:inputImage forKey:kCIInputImageKey];
            [filter setValue:[NSNumber numberWithInteger:10] forKey:@"inputRadius"];
            // blur image
            CIImage *result = [filter valueForKey:kCIOutputImageKey];
            CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
                        UIImageView *outImgView = (UIImageView *)tmpimg.subviews.firstObject;
            outImgView.image = image;



        }
    if ([noti.userInfo[@"type"] isEqual:[NSNumber numberWithInteger:0]])  {//delete
        
        if ([self.subviews.lastObject isKindOfClass:[XIU_EditorDrawItemView class]]) {
            [tmpimg removeFromSuperview];
            if ([self.subviews.lastObject isKindOfClass:[XIU_EditorDrawItemView class]]) {
                tmpimg = self.subviews.lastObject;
            }else {
                return;
            }
        }
    }
    if ([noti.userInfo[@"type"] isEqual:[NSNumber numberWithInteger:4]])  {//clone
        UIImage *img = tmpimg.imgView.image;

        XIU_EditorDrawItemView *view = [[XIU_EditorDrawItemView alloc] initWithFrame:CGRectMake(tmpimg.frame.origin.x + 30, tmpimg.frame.origin.y, tmpimg.frame.size.width, tmpimg.frame.size.height) Image:img];
        tmpimg = view;
        [self addSubview:view];
        [self initGesturesWithView:view];

    }
    if ([noti.userInfo[@"type"] isEqual:[NSNumber numberWithInteger:6]]) {//剪裁
        TOCropViewController * cropViewController = [[TOCropViewController alloc] initWithImage:[(UIImageView *)tmpimg.subviews.firstObject image]];
        cropViewController.delegate = self;
        [ editorController  presentViewController: cropViewController animated:YES  completion:nil ];
    }
    
    if ([noti.userInfo[@"type"] isEqual:@7]) {
        CATransform3D trans = CATransform3DIdentity;
        NSInteger num = [noti.userInfo[@"value"] integerValue];
        trans.m34 = -(num/100);
        trans = CATransform3DRotate(trans, M_PI/4, 0, 1, 0);
        
        NSInteger y = num > 0 ? 1 : -1;
        CATransform3D catrScale = CATransform3DMakeRotation(ABS(num)* M_PI/180, 1, y, 0);
        tmpimg.subviews.firstObject.layer.transform = catrScale;
    }
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    
    UIImageView *img = (UIImageView *)tmpimg.subviews.firstObject;
    img.image = image;
}
@end
