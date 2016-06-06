//
//  UIView+NameExtensions.h
//  UIView-C04
//
//  Created by BobZhang on 16/6/3.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NameExtensions)

@property (nonatomic,strong) NSString *nameTag;
- (UIView *)viewNamed:(NSString *)aName;
- (void)dumpViewAtIndent:(int)indent intoMutalbeString:(NSMutableString *)outString;
@end
