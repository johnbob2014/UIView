//
//  UIView+Transform.h
//  UIView-C04
//
//  Created by BobZhang on 16/6/6.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Transform)

@property (readonly) CGFloat rotation;
@property (readonly) CGFloat xscale;
@property (readonly) CGFloat yscale;
@property (readonly) CGFloat tx;
@property (readonly) CGFloat ty;

@property (readonly) CGRect originalFrame;
@property (readonly) CGPoint transformedTopLeft;
@property (readonly) CGPoint transformedTopRight;
@property (readonly) CGPoint transformedBottomLeft;
@property (readonly) CGPoint transformedBottomRight;

- (CGPoint)pointInTransformedView:(CGPoint)pointInParentCoordinates;
- (BOOL)intersectsView:(UIView *)aView;

@end
