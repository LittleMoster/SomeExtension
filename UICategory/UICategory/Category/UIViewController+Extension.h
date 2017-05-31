//
//  UIViewController+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/**
 *无需添加类的头文件就可以直接调用其他类的方法(无参数)
 */
-(void)performClassName:(NSString*)className perfromName:(NSString*)perfromName;


-(id)performClassName:(NSString*)className perfromName:(NSString*)perfromName objc:(id)objc;

//对键盘的弹出做响应，防止挡住输入文本框
@property(nonatomic,assign)BOOL changeViewkeyBoard;
@end
