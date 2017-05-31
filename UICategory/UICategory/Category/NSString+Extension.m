//
//  NSString+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "NSString+Extension.h"

#define URLregixted @"/^((ht|f)tps?):\/\/([\w\-]+(\.[\w\-]+)*\/)*[\w\-]+(\.[\w\-]+)*\/?(\?([\w\-\.,@?^=%&:\/~\+#]*)+)?/"
@implementation NSString (Extension)


//-(NSString *)URLinStrToStr:(NSString *)str
//{
//    //找出字符串中的url
////    通过正在匹配
//    //    转换成其他的文字
//
//    return  [self stringByReplacingOccurrencesOfRegex:URLregixted withString:str];
//
//}


-(NSDate *)stringTodate
{
   
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    return [fmt dateFromString:self];
    
}


-(NSAttributedString*)lightText:(NSString *)str showTextColor:(UIColor*)color ForeOrBack:(ForeOrBackType)colorType
{

    NSString *labelColorType;
    if (colorType==NSForegroundColor) {
        labelColorType=NSForegroundColorAttributeName;
    }else
    {
        labelColorType=NSBackgroundColorAttributeName;
    }
        NSRange index=[self rangeOfString:str];
         NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self];
        if (index.length!=0) {
           
           
            //设置：在3~length-3个单位长度内的内容显示成橙色
            [butedString addAttribute:labelColorType value:color range:NSMakeRange(index.location, index.length)];
    
            BOOL success=YES;
            while (success) {
                if ((index.length+index.location)<self.length &&(self.length-index.length-index.location)>str.length) {
                    
                    
                    NSString *laststr=[self substringFromIndex:index.length+index.location];
                    
                    NSRange rang= [laststr rangeOfString:str];
                    
                    index.location=index.location+index.length+rang.location;
                    if (index.length!=0) {
                    [butedString addAttribute:labelColorType value:color range:index];
                    
                    }
                 
                    
                    
                }else
                {
                    success=NO;
                }
            }
           
        }

            return  butedString;
    
}

-(NSAttributedString *)setText:(NSString *)textStr addAttribute:(NSString *)Attribute value:(id)value
{
    

    NSRange index=[self rangeOfString:textStr];
    NSMutableAttributedString *butedString = [[NSMutableAttributedString alloc]initWithString:self];
    if (index.length!=0) {
        
        
        //设置：在3~length-3个单位长度内的内容显示成橙色
        [butedString addAttribute:Attribute value:value range:NSMakeRange(index.location, index.length)];
        
        BOOL success=YES;
        while (success) {
            if ((index.length+index.location)<self.length &&(self.length-index.length-index.location)>textStr.length) {
                
                
                NSString *laststr=[self substringFromIndex:index.length+index.location];
                
                NSRange rang= [laststr rangeOfString:textStr];
                
                index.location=index.location+index.length+rang.location;
                if (index.length!=0) {
                    [butedString addAttribute:Attribute value:value range:index];
                    
                }
                
                
                
            }else
            {
                success=NO;
            }
        }
        
    }
    
    return  butedString;
    

}

@end
