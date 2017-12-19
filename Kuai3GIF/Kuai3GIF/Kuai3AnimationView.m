//
//  Kuai3AnimationView.m
//  Kuai3GIF
//
//  Created by feipeng on 2017/12/12.
//  Copyright © 2017年 feipeng. All rights reserved.
//

#import "Kuai3AnimationView.h"
#import "UIView+Kuai3Frame.h"


#define kK3ScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define kK3ScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)



#define kK3ImageWidth 290 * kK3ScreenWidth / 375.0

/**
 整个图片的高

 @param kK3ScreenWidth * 446/1242.0 根据图片的宽来动态计算
 @return 图片高
 */
#define kK3ImageHeight (kK3ScreenWidth * 446/1242.0)

/**
 色子的宽

 @param kK3ScreenWidth *70/1242.0 根据整个图片等宽来动态计算
 @return 色子的宽
 */
#define kCenterImageWidth (kK3ScreenWidth * 70/1242.0)

/**
 色子偏移距离
 */
#define TransformTranslateY (16)

/**
 GIF数据源相关参数
 */
#define AllTime (12.0) // gif时间
#define kAllImageCount 92 // 所有图片数量
#define kDiceBaginCount 54 // 色子开始图片
#define kDiceCount 33 // 色子运动图片个数
#define kSepTime 0.12 // 每一帧动画时间
#define kSlacTime kSepTime * 8  // 旋转动画时间

@interface Kuai3AnimationView()

/**
 GIF背景
 */
@property (nonatomic, strong) UIImageView * gifImageView;

/**
 左边色子
 */
@property (nonatomic, strong) UIImageView * leftImage;

/**
 中间色子
 */
@property (nonatomic, strong) UIImageView * centerImage;

/**
 右边色子
 */
@property (nonatomic, strong) UIImageView * rightImage;

@property (nonatomic, strong) NSTimer * timer;

/**
 图片下表
 */
@property (nonatomic, assign) NSInteger index;

/**
 GIF数据源
 */
@property (nonatomic, strong) NSMutableArray * images;

/**
 是否停止动画
 */
@property (nonatomic, assign) BOOL isFinish;
@end

@implementation Kuai3AnimationView

-(instancetype)init {
    if (self == [super init]) {
        self.frame = CGRectMake((kK3ScreenWidth - kK3ImageWidth)/2.0, (kK3ScreenHeight - kK3ImageHeight)/2.0, kK3ImageWidth, kK3ImageHeight);
        self.gifImageView.backgroundColor = [UIColor clearColor];
        _index = 1;
    }
    return self;
}

#pragma mark -- setter和getter
-(UIImageView *)gifImageView {
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kK3ImageWidth, kK3ImageHeight)];
        _gifImageView.image = [UIImage imageNamed:@"8899-2 - 050006"];
        [self addSubview:_gifImageView];
    }
    return _gifImageView;
}

-(UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.centerImage.k3_left - kCenterImageWidth, self.centerImage.k3_top + kCenterImageWidth, kCenterImageWidth, kCenterImageWidth)];
        _leftImage.transform = CGAffineTransformMakeRotation(-M_PI/6);
        _leftImage.hidden = YES;
        [self addSubview:_leftImage];
    }
    return _leftImage;
}

-(UIImageView *)centerImage {
    if (!_centerImage) {
        _centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(_gifImageView.k3_centerX - kCenterImageWidth/2.0, _gifImageView.k3_centerY - kCenterImageWidth/2.0, kCenterImageWidth, kCenterImageWidth)];
        _centerImage.hidden = YES;
        [self addSubview:_centerImage];
    }
    return _centerImage;
}

-(UIImageView *)rightImage {
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.centerImage.k3_left + kCenterImageWidth, self.centerImage.k3_top + kCenterImageWidth, kCenterImageWidth, kCenterImageWidth)];
        _rightImage.hidden = YES;
        _rightImage.transform = CGAffineTransformMakeRotation(M_PI/6);
        [self addSubview:_rightImage];
    }
    return _rightImage;
}

-(NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kSepTime repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            if (!_isFinish) {
                if (_index == 44) {
                    _index = 40;
                }
            }
            
            if (_index == kDiceBaginCount) {
                [self imageRun];
            }
            else if (_index == kAllImageCount)
            {
                [self finishGIF];
            }
            else if (_index <= kAllImageCount)
            {
                self.gifImageView.image = [UIImage imageWithContentsOfFile:[self.images objectAtIndex:_index]];
            }
            _index ++;
        }];
    }
    return _timer;
}

-(NSArray<UIImage *> *)images {
    if (!_images) {
        _images = [NSMutableArray array];
        NSArray * arr = @[@1,@44, @1, @40, @6];
        for (NSInteger i = 0; i < arr.count ; i ++) {
            NSNumber * num = arr[i];
            for (NSInteger j = 1; j < num.integerValue + 1; j ++) {
                NSString * buildPath =  [[NSBundle mainBundle] pathForResource:@"kuai3Image" ofType:@"bundle"];
                NSString *imageName=[NSString stringWithFormat:@"GIFImage/%ld/8899-2 - 0%ld%04ld.png",i+1,i+1,j];
                NSString * imagePaht = [buildPath stringByAppendingPathComponent:imageName];
                [_images addObject:imagePaht];
            }
        }
    }
    return _images;
}

#pragma mark -- 业务逻辑
/**
 根据号码选择色子

 @param nums 号码源
 */
-(void)setNumViewWithArray:(NSArray *)nums {
    self.leftImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"c_%@", nums[0]]];
    self.centerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"c_%@", nums[1]]];
    self.rightImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"c_%@", nums[2]]];
}


/**
 GIF 开始运动
 */
-(void)showInView: (UIView *)view {
    [view addSubview:self];
    [self.timer fire];
}


/**
 色子运动
 */
-(void)imageRun {
    self.leftImage.hidden = NO;
    self.centerImage.hidden = NO;
    self.rightImage.hidden = NO;
    CGFloat allTime = kSepTime * kDiceCount;
    [UIView animateWithDuration:allTime animations:^{
            self.leftImage.k3_centerX -= TransformTranslateY/1.414;
            self.centerImage.k3_centerY -= TransformTranslateY;
            self.rightImage.k3_centerX += TransformTranslateY/1.414;
    }];
}

-(void)stopWithNums:(NSArray *)nums AndfinishBlock: (finishBlock)finishBlock {
    [self setNumViewWithArray:nums];
    _isFinish = YES;
    finishBlock();
}


/**
 全部数据初始化
 */
-(void)finishGIF {
    [self removeFromSuperview];
    _index = 0;
    [self.timer invalidate];
    self.timer = nil;
    [self.leftImage removeFromSuperview];
    self.leftImage = nil;
    [self.centerImage removeFromSuperview];
    self.centerImage = nil;
    [self.rightImage removeFromSuperview];
    self.rightImage = nil;
    _isFinish = NO;
    self.gifImageView.image = [UIImage imageWithContentsOfFile:[self.images objectAtIndex:_index]];
}

-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
