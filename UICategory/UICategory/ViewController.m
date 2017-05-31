//
//  ViewController.m
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Extension.h"
#import "UIImage+Extrnsion.h"
#import "UILabel+Extension.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "UITextField+Extension.h"
#import "UITextView+Extension.h"
#import "NSString+Extension.h"
#import "UIViewController+Extension.h"

#import "UIViewController+Extension.h"

#import "ArchiveTool.h"
#import "NSMutableArray+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "StareView.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    StareView *view=[[StareView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    view.backgroundColor=[UIColor blueColor];
    
    [self.view addSubview:view];
}

-(void)ClickBtn:(NSString *)text
{
    NSLog(@"%@",text);
}
@end
