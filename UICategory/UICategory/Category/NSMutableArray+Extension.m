//
//  NSMutableArray+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (Extension)


-(void)changeAtIndex:(NSInteger)index1 andIndex:(NSInteger)index2
{
    if (self.count==0 ||self.count<index1 ||self.count<index2) {
        NSLog(@"数组越界了");
        return;
    }
    //保存对应下标的值
    id value1=self[index1];
    id value2=self[index2];
    
    [self replaceObjectAtIndex:index1 withObject:value2];
    
    [self replaceObjectAtIndex:index2 withObject:value1];

}

-(void)InsterAtIndex:(NSInteger)Atindex ToIndex:(NSInteger)Toindex
{
    
    if (self.count==0 ||self.count<Atindex ||self.count<Toindex) {
        NSLog(@"数组越界了");
        return;
    }
    if (Atindex>Toindex) {
        id value=self[Toindex];
        [self replaceObjectAtIndex:Toindex withObject:self[Atindex]];
        
        [self insertObject:value atIndex:Toindex+1];
        
        [self removeObjectAtIndex:Atindex+1];

    }else if (Atindex<Toindex)
    {
        
        [self insertObject:self[Atindex] atIndex:Toindex];
        
        [self removeObjectAtIndex:Atindex];
    }
    
    
}
@end
