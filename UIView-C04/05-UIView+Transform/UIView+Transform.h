//
//  UIView+Transform.h
//  UIView-C04
//
//  Created by BobZhang on 16/6/6.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Transform)

/**
 变换后的旋转量 - Transform
 */
@property (readonly) CGFloat rotation;

/**
 x轴上的缩放 - Transform
 */
@property (readonly) CGFloat xscale;

/**
 y轴上的绽放 - Transform
 */
@property (readonly) CGFloat yscale;

/**
 变换的tx值 - Transform
 */
@property (readonly) CGFloat tx;

/**
 变换的ty值 - Transform
 */
@property (readonly) CGFloat ty;

/**
 视图变换前的frame - Transform
 */
@property (readonly) CGRect originalFrame;

/**
 变换后的 TopLeft 点 - Transform
 */
@property (readonly) CGPoint transformedTopLeft;

/**
 变换后的 TopRight 点- Transform
 */
@property (readonly) CGPoint transformedTopRight;

/**
 变换后的 BottomLeft 点- Transform
 */
@property (readonly) CGPoint transformedBottomLeft;

/**
 变换后的 TopLeft 点- Transform
 */
@property (readonly) CGPoint transformedBottomRight;

/**
 返回指定的点经过变换后的位置 - Transform
 */
- (CGPoint)pointInTransformedView:(CGPoint)pointInParentCoordinates;

/**
 判断变换后的视图是否与指定视图相交 - Transform
 */
- (BOOL)intersectsView:(UIView *)aView;

@end
