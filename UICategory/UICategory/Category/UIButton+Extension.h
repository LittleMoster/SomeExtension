//
//  UIButton+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface UIButton (Extension)

//btn显示成圆角
//@property(nonatomic,assign)BOOL waneBtn;
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents isContinueClick:(BOOL)iscontinue;

@end
