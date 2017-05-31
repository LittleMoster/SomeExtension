//
//  ColorTool.h
//  UICategory
//
//  Created by cguo on 2017/5/12.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorTool : NSObject

//将UIColor转换为RGB值
+(NSMutableArray *) changeUIColorToRGB:(UIColor *)color;
@end
