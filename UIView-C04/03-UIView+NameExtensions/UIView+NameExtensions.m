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

- (UIView *)viewWithNameTag:(NSString *)aNameTag{
    if (!aNameTag) return nil;
    
    if ([self.nameTag isEqualToString:aNameTag]) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        //Recursively call viewWithNameTag: method to check subviews
        UIView *resultView=[subView viewWithNameTag:aNameTag];
        if (resultView) return resultView;
    }
    
    return nil;
}

//Recursively travel down the view tree,increasing the indentation level for children
- (void)dumpViewAtIndent:(int)indent intoMutableString:(NSMutableString *)outString{
    //Add the indentation
    for (int i = 0; i < indent; i++)
        [outString appendString:@"--"];
    
    //Add the class description
    [outString appendFormat:@"[%2d] %@\n",indent,[[self class] description]];
    
    //Recurse on subviews
    for (UIView *subView in self.subviews) {
        [subView dumpViewAtIndent:indent + 1 intoMutableString:outString];
    }
}

- (void)dumpViewIntoMutableString:(NSMutableString *)outString{
    [self dumpViewAtIndent:0 intoMutableString:outString];
}

@end
