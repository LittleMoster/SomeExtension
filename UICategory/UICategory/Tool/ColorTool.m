//
//  ColorTool.m
//  UICategory
//
//  Created by cguo on 2017/5/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ColorTool.h"

@implementation ColorTool

//将UIColor转换为RGB值
+(NSMutableArray *) changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    //获取红色值
    int r = [[RGBArr objectAtIndex:1] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",r];
    [RGBStrValueArr addObject:RGBStr];
    //获取绿色值
    int g = [[RGBArr objectAtIndex:2] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",g];
    [RGBStrValueArr addObject:RGBStr];
    //获取蓝色值
    int b = [[RGBArr objectAtIndex:3] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",b];
    [RGBStrValueArr addObject:RGBStr];
    //返回保存RGB值的数组
    return RGBStrValueArr;
}
-(int)gotothe
{
     NSLog(@"点击fffff");
    int age=20;
    return age;
}
-(int )click:(int )age
{
    NSLog(@"点击了");
    age+=12;
//    NSMutableArray *arr=[[NSMutableArray alloc]init];
  
    return age;
}
+(NSDictionary* )run:(NSString* )age
{
    NSLog(@"快跑");
    age=[age stringByAppendingString:@"添加"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"mydic"]=age;
       return dic;
}
@end
