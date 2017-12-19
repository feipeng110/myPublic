//
//  Kuai3AnimationView.h
//  Kuai3GIF
//
//  Created by feipeng on 2017/12/12.
//  Copyright © 2017年 feipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishBlock)(void);

@interface Kuai3AnimationView : UIView

/**
 初始化
 */
-(instancetype)init;


/**
 GIF动画出现
 */
-(void)showInView: (UIView *)view;


/**
 拿到开奖号码并停止

 @param nums 开奖号码 (nums是1-6之间的字符串，而且nums里面的元素个数大于3)
 @param finishBlock 返回回调
 */
-(void)stopWithNums:(NSArray *)nums AndfinishBlock: (finishBlock)finishBlock;

@end
