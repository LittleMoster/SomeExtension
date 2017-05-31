//
//  UIButton+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation UIButton (Extension)



+(void)load
{

}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isContinueClick:(BOOL)iscontinue
{
    [[self rac_signalForControlEvents:controlEvents]subscribeNext:^(id x) {
        if (iscontinue==NO) {
            if (self.isSelected) {
                NSLog(@"不能重复点击");
            }else
            {
                [target performSelector:action];
                self.selected=YES;
            }
  
        }
    }];
}


-(void)setZy_Wane:(BOOL)Wane
{
    objc_setAssociatedObject(self, @selector(zy_Wane), @(Wane), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)zy_Wane
{
    return objc_getAssociatedObject(self, @selector(zy_Wane));
}





@end
