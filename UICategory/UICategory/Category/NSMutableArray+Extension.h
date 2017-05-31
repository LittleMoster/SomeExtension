//
//  NSMutableArray+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extension)




/**
 *交换元素的位置
*/
-(void)changeAtIndex:(NSInteger)index1 andIndex:(NSInteger)index2;


/**
 *把某位置的元素移到指定的位置。指定位置后的元素往后移
 */
-(void)InsterAtIndex:(NSInteger)Atindex ToIndex:(NSInteger)Toindex;

@end
