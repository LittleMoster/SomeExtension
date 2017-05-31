//
//  UIBarButtonItem+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/25.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    UIBarButtonItemStateNormal,
    UIBarButtonItemStateDisenable,
}UIBarButtonItemState;

/*
 一个把UIBarButtonItem当Button使用的类，
 */
@interface UIBarButtonItem (Extension)

/*
 *和button一样的用法
 */
-(void)addTarget:(id)target Action:(SEL)action;

-(void)setImage:(UIImage *)image forState:(UIControlState)state;

-(void)setTitle:(NSString *)title forState:(UIControlState)state;

-(void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state;

/*
 *初始化barbutton
 */
-(UIBarButtonItem*)initWitnBtnFrame:(CGRect)frame;

@property(nonatomic,strong)UIButton *Barbtn;

@property(nonatomic,assign,getter=isEnabled)BOOL enabled;
@property(nonatomic,assign,getter=isSelected)BOOL selected;
@property(nonatomic,assign,getter=isHighlighted)BOOL highlighted;

@property(nonatomic)          BOOL         adjustsImageWhenHighlighted;    
@property(nonatomic)          BOOL         adjustsImageWhenDisabled;
@end
