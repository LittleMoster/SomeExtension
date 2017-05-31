//
//  ArchiveTool.m
//  UICategory
//
//  Created by cguo on 2017/5/20.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ArchiveTool.h"
#import <objc/message.h>



@implementation ArchiveTool


/**
 *对象进行归档保存
 */
-(void)SaveForArchive
{
    
  NSString *path=  [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",NSStringFromClass([self class])]];
    
    [NSKeyedArchiver archiveRootObject:self toFile:path];

}
/**
 *对象进行解档创建对象
 */
+(instancetype)GetForArchive
{
    NSString *path=  [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",NSStringFromClass([self class])]];
                      
   return  [NSKeyedUnarchiver unarchiveObjectWithFile:path ];
    
   
}

/**
 *归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars=class_copyIvarList([ArchiveTool class], &count);
    
    
    for ( int i=0; i<count; i++) {
          const char *ivarName = ivar_getName(ivars[i]);
        [aCoder encodeObject:[self valueForKey:[NSString stringWithUTF8String:ivarName]] forKey:[NSString stringWithUTF8String:ivarName]];
    }
}
/**
 *解档
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
  
        Ivar *ivars=class_copyIvarList([self class], &count);
        
        
        for (int i=0; i<count; i++) {
            const char *ivarName = ivar_getName(ivars[i]);
            
            [self setValue:[aDecoder decodeObjectForKey:[NSString stringWithUTF8String:ivarName]] forKey:[NSString stringWithUTF8String:ivarName]];
            
        }
    }
    
    return self;
}
@end
