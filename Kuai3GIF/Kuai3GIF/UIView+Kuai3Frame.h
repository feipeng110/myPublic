//
//  UIView+Kuai3Frame.h
//  Kuai3GIF
//
//  Created by feipeng on 2017/12/14.
//  Copyright © 2017年 feipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Kuai3Frame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint k3_origin;
@property (nonatomic, assign) CGSize k3_size;

// shortcuts for positions
@property (nonatomic) CGFloat k3_centerX;
@property (nonatomic) CGFloat k3_centerY;


@property (nonatomic) CGFloat k3_top;
@property (nonatomic) CGFloat k3_bottom;
@property (nonatomic) CGFloat k3_right;
@property (nonatomic) CGFloat k3_left;

@property (nonatomic) CGFloat k3_width;
@property (nonatomic) CGFloat k3_height;
@end
