//
//  UITextField+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/8.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>
@implementation UITextField (Extension)


+ (void)initialize
{
//    [self getIvars];
    
//    [self getProperties];
}

+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字
        NSLog(@"%s   <---->   %s", property_getName(property), property_getAttributes(property));
    }
    
    free(properties);
}

+ (void)getIvars
{
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}


-(BOOL)becomeFirstResponder
{
 
    if (self.zy_placeholderLabelHeightColor !=nil) {
         [self setValue:self.zy_placeholderLabelHeightColor forKeyPath:@"_placeholderLabel.textColor"];
    }
  return   [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder
{
    if (self.zy_placeholderLabelColor !=nil) {
        [self setValue:self.zy_placeholderLabelColor forKeyPath:@"_placeholderLabel.textColor"];

    }
    return  [super becomeFirstResponder];
}
-(void)setPlaceholderLabelColor:(UIColor *)placeholderLabelColor
{
    self.zy_placeholderLabelColor=placeholderLabelColor;
    // 修改占位文字颜色
    [self setValue:placeholderLabelColor forKeyPath:@"_placeholderLabel.textColor"];
}
-(void)setPlaceholderLabelHeightColor:(UIColor *)placeholderLabelHeightColor
{
    self.zy_placeholderLabelHeightColor=placeholderLabelHeightColor;
    self.tintColor=[UIColor blueColor];
}
-(UIColor *)placeholderLabelHeightColor
{
    return self.zy_placeholderLabelHeightColor;
}
-(UIColor *)placeholderLabelColor
{
     return self.zy_placeholderLabelColor;
}
-(UILabel *)placeholderLabel
{
    return self.zy_placeholderLabel;
}
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    [self setValue:placeholderLabel forKeyPath:@"_placeholderLabel"];
    self.zy_placeholderLabel=placeholderLabel;
    self.zy_placeholderLabelColor=placeholderLabel.textColor;
}


- (void)setZy_placeholderLabel:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderLabel), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UILabel *)zy_placeholderLabel {
    return objc_getAssociatedObject(self, @selector(zy_placeholderLabel));
}

- (void)setZy_placeholderLabelColor:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderLabelColor), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIColor *)zy_placeholderLabelColor {
    return objc_getAssociatedObject(self, @selector(zy_placeholderLabelColor));
}

- (void)setZy_placeholderLabelHeightColor:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderLabelHeightColor), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIColor *)zy_placeholderLabelHeightColor {
    return objc_getAssociatedObject(self, @selector(zy_placeholderLabelHeightColor));
}

@end
