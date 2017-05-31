//
//  UIBarButtonItem+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/25.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation UIBarButtonItem (Extension)

+(void)load
{
    [self getProperties];
    
    [self getIvars];
}
+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
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
    Ivar *ivars = class_copyIvarList([self class], &count);
    
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

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.Bar_btn=self.customView;
    [self.Barbtn setBackgroundImage:image forState:state];
 
    self.customView=self.Barbtn;
//    [self initWithCustomView:self.Bar_btn];
//    [[UIBarButtonItem alloc]initWithCustomView:self.Bar_btn];

}
-(UIBarButtonItem*)initWitnBtnFrame:(CGRect)frame
{
    self.Barbtn.frame=frame;
    return [[UIBarButtonItem alloc] initWithCustomView: self.Barbtn];
}
-(void)setBarbtn:(UIButton *)Barbtn
{
    self.Bar_btn=Barbtn;
   
}
-(UIButton *)Barbtn
{
    if (self.Bar_btn==nil) {
        self.Bar_btn=[[UIButton alloc]init];
    }
    return  self.Bar_btn;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.Bar_btn=self.customView;
    [self.Barbtn setTitle:title forState:state];
    
    self.customView=self.Barbtn;
}

-(void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state
{
    self.Bar_btn=self.customView;
    [self.Barbtn setTitleColor:titleColor forState:state];

    
    self.customView=self.Barbtn;
//    [self initWithCustomView:self.Bar_btn];
}

-(void)addTarget:(id)target Action:(SEL)action
{
    if ([self.customView isKindOfClass:[UIButton class]]) {
       
        self.Bar_btn=self.customView;
        [self.Barbtn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
        
    }else
    {
    [self setTarget:target];
    [self setAction:action];
    }
}

-(void)setHighlighted:(BOOL)highlighted
{
     self.Bar_btn=self.customView;
    self.Barbtn.highlighted=highlighted;
}
-(BOOL)isHighlighted
{
     self.Bar_btn=self.customView;
    return self.Barbtn.isHighlighted;
}
-(BOOL)isSelected
{
     self.Bar_btn=self.customView;
    return self.Barbtn.isSelected;
}
-(void)setSelected:(BOOL)selected
{
    self.Bar_btn=self.customView;
    self.Barbtn.selected=selected;
}

-(void)setEnabled:(BOOL)enabled
{
    self.Bar_btn=self.customView;
    self.Barbtn.enabled=enabled;
}
-(BOOL)isEnabled
{
    self.Bar_btn=self.customView;
    return self.Barbtn.enabled;
}

-(BOOL)adjustsImageWhenHighlighted
{
    self.Bar_btn=self.customView;
    return self.Barbtn.adjustsImageWhenHighlighted;
}
-(void)setAdjustsImageWhenHighlighted:(BOOL)adjustsImageWhenHighlighted
{
    self.Bar_btn=self.customView;
    self.Barbtn.adjustsImageWhenHighlighted=adjustsImageWhenHighlighted;
}
-(void)setAdjustsImageWhenDisabled:(BOOL)adjustsImageWhenDisabled
{
    self.Bar_btn=self.customView;
     self.Barbtn.adjustsImageWhenDisabled=adjustsImageWhenDisabled;
}
-(BOOL)adjustsImageWhenDisabled
{
    self.Bar_btn=self.customView;
    return self.Barbtn.adjustsImageWhenDisabled;
}

- (UIButton *)Bar_btn {
    return objc_getAssociatedObject(self, @selector(Bar_btn));
}
- (void)setBar_btn:(id)object {
    objc_setAssociatedObject(self, @selector(Bar_btn), object,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
@end
