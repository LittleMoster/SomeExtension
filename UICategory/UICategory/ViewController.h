//
//  ViewController.h
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTest;

-(void)ClickBtn:(NSString *)text;
@end

