//
//  UIView+NameExtensions.h
//  UIView-C04
//
//  Created by BobZhang on 16/6/3.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NameExtensions)

/**
视图的nameTag属性 - NameExtensions
 */
@property (nonatomic,strong) NSString *nameTag;

/**
查找指定nameTag的视图 - NameExtensions
 */
- (UIView *)viewWithNameTag:(NSString *)aNameTag;

/**
分析视图层级，并输出到给定的可变字符串 - NameExtensions
 */
- (void)dumpViewIntoMutableString:(NSMutableString *)outString;

@end
