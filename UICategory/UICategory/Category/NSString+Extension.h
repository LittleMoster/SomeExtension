//
//  NSString+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
   NSForegroundColor ,//前景色
   NSBackgroundColor   //背景色
}ForeOrBackType;


@interface NSString (Extension)



/*
 *改变指定文字的颜色
 */
-(NSAttributedString*)lightText:(NSString *)str showTextColor:(UIColor*)color ForeOrBack:(ForeOrBackType)colorType;

/**
 *设置指定内容改变其属性 textStr为需要改变的指定内容
 */
-(NSAttributedString*)setText:(NSString*)textStr addAttribute:(NSString *)Attribute value:( id)value ;

/**
 *字符串转化成日期格式
 */
-(NSDate*)stringTodate;
//把字符串中的URL转化成文字
-(NSString*)URLinStrToStr:(NSString*)str;
@end
