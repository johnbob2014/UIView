//
//  UIView+NameExtensions.m
//  UIView-C04
//
//  Created by BobZhang on 16/6/3.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import "UIView+NameExtensions.h"
#import <objc/runtime.h>

static const char kNameTag;

@implementation UIView (NameExtensions)

#pragma mark Associations

- (id)nameTag{
    return  objc_getAssociatedObject(self, (void *) &kNameTag);
}

- (void)setNameTag:(NSString *)nameTag{
    objc_setAssociatedObject(self,(void *) &kNameTag, nameTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Methods

- (UIView *)viewNamed:(NSString *)aName{
    if (!aName) return nil;
    
    if ([self.nameTag isEqualToString:aName]) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        //Recursively call viewNamed: method to check subviews
        UIView *resultView=[subView viewNamed:aName];
        if (resultView) return resultView;
    }
    
    return nil;
}
@end