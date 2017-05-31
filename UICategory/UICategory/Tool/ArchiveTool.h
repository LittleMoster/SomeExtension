//
//  ArchiveTool.h
//  UICategory
//
//  Created by cguo on 2017/5/20.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *该类相当于是一个模板类，在新建自己的一个模型类时，如需要使用归档，就可以直接把该类中相关的一些功能代码的两个方法粘贴到自己的类中即可。
 */
@interface ArchiveTool : NSObject<NSCoding>


@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)int age;
@property(nonatomic,assign)int age2;
@property(nonatomic,assign)int age3;

/**
 *对象进行归档保存
 */
-(void)SaveForArchive;
/**
 *对象进行解档创建对象
 */
+(instancetype)GetForArchive;
@end
