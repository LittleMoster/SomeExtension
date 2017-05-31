//
//  UITextView+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 *设置占位文字label
 */
@property (nonatomic, strong) UILabel *placeholderLabel;
/**
 *设置占位文字的text
 */
@property (nonatomic, strong) NSString *placeholder;
/**
 *设置占位文字的颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;
/**
 *当textView成为第一响应者时的占位文字的颜色----存在问题（设置之后光标不显示）
 */
@property(nonatomic,strong)UIColor * placeholderHeightlightColor;
/**
 *当textView成为第一响应者时的占位Label----存在问题（设置之后光标不显示）
 */
@property (nonatomic, strong) NSString *Heightlightplaceholder;
/**
 *获取输入的文字的字数
 */
-(int)getInputTextNum;


-(void)getInputTextNumWithBlock:(void(^)(int num))block;

@end
