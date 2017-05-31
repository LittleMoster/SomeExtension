//
//  UIViewController+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/9.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (Extension)




//如果设置自动改变输入框的位置来防止键盘挡住输入框就设置成YES
-(void)setChangeViewkeyBoard:(BOOL)changeViewkeyBoard
{
    self.zy_ViewframeWithKetboard=changeViewkeyBoard;
    if (changeViewkeyBoard) {
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeframeViewkeyboardhide:) name:UIKeyboardDidHideNotification object:nil];
                 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeframeViewViewkeyboardshow:) name:UIKeyboardDidShowNotification object:nil];
    }
}

-(BOOL)changeViewkeyBoard
{
    return self.zy_ViewframeWithKetboard;
}

-(void)changeframeViewViewkeyboardshow:(NSNotification*)note
{
    CGRect keyboardframe = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    NSString *className=NSStringFromClass([self class]);
    if ([className hasPrefix:@"UI"]==NO) {
        for (UIView *view in self.view.subviews) {
            
            if ([NSStringFromClass([view class]) isEqualToString:@"UITextField"] || [NSStringFromClass([view class]) isEqualToString:@"UITextView"]) {
                CGRect frame= view.frame;
                
                if (frame.origin.y>keyboardframe.origin.y-70) {
                    frame.origin.y=keyboardframe.origin.y-100;
                     self.zy_fallHight=view.frame.origin.y-frame.origin.y;
                }
                for (UIView *view in self.view.subviews) {
                    CGRect frame= view.frame;
                    
                    frame.origin.y-= self.zy_fallHight;
                    view.frame=frame;
                }
            }
        }
    }
    
}


//当键盘隐藏时调用改代码
-(void )changeframeViewkeyboardhide:(NSNotification*)note
{

    NSString *className=NSStringFromClass([self class]);
    if ([className hasPrefix:@"UI"]==NO) {
        for (UIView *view in self.view.subviews) {
            
            CGRect frame=view.frame;
            if (self.zy_fallHight>0) {
                frame.origin.y-= self.zy_fallHight;
                view.frame=frame;
            }
            }
    }
    
}


-(void)performClassName:(NSString*)className perfromName:(NSString*)perfromName
{

    
    if (className!=nil &&className.length>0 &&perfromName!=nil &&perfromName.length>0) {
   
        @try {
      objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([className  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([perfromName UTF8String])) ;
           
        } @catch (NSException *exception) {
            @try {
   objc_msgSend(objc_getClass([className  UTF8String]), sel_registerName([perfromName UTF8String]));
               
            } @catch (NSException *exception) {
                 NSLog(@"类名或方法名不正确");
            } @finally {
                
            }
        } @finally {
        
        }
        
    }else{
        NSLog(@"方法名为空或类名为空");
    }

}
-(id)performClassName:(NSString*)className perfromName:(NSString*)perfromName objc:(id)objc
{
    NSLog(@"%@",NSStringFromClass([objc class]));
    if ([NSStringFromClass([objc class]) hasSuffix:@"NSCFNumber"]) {
        
    }
    if (className!=nil &&className.length>0 &&perfromName!=nil &&perfromName.length>0 ) {
        id objName;
        @try {
     objName=  objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass([className  UTF8String]), sel_registerName("alloc")), sel_registerName("init")), sel_registerName([perfromName UTF8String]),objc) ;
        } @catch (NSException *exception) {
        
            @try {
          objName= objc_msgSend(objc_getClass([className  UTF8String]), sel_registerName([perfromName UTF8String]),objc);
            } @catch (NSException *exception) {
                NSLog(@"类名或方法名不正确");
            } @finally {
               
            }
       
        } @finally {
            return objName;
        }
        
    }else{
        NSLog(@"方法名为空或类名为空");
    }

}





+(void)load
{
    //我们只有在开发的时候才需要查看哪个viewController将出现
    //所以在release模式下就没必要进行方法的交换，如果release模式下也要的话，请注释
    
    
#ifdef DEBUG
    
    //原本的viewWillAppear方法
    //两方法进行交换
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewWillAppear:)), class_getInstanceMethod(self, @selector(logViewWillAppear:)));
    
    //原本的viewWillAppear方法
    //两方法进行交换
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewDidDisappear:)), class_getInstanceMethod(self, @selector(logviewDidDisappear:)));
    
#endif
    
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(logDealloc)));
}
-(void)logDealloc
{
    [self logDealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)logviewDidDisappear:(BOOL)animated
{

    [self logviewDidDisappear:animated];
}

-(void)logViewWillAppear:(BOOL)animated
{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    NSString *className=NSStringFromClass([self class]);
    
    if ([className hasPrefix:@"UI"]==NO) {
//        NSLog(@"现在执行的是%@控制器名称",className);
        
    }
    [self logViewWillAppear:animated];
    
   
}





-(void)logViewDidLoad
{
    NSString *className=NSStringFromClass([self class]);
    
    if ([className hasPrefix:@"UI"]==NO) {
        NSLog(@"执行了控制器---%@",className);
    }
    
    [self logViewDidLoad];
}

- (void)setZy_ViewframeWithKetboard:(BOOL)ViewframeWithKetboard {
    objc_setAssociatedObject(self, @selector(zy_ViewframeWithKetboard), @(ViewframeWithKetboard), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)zy_ViewframeWithKetboard {
    return objc_getAssociatedObject(self, @selector(zy_ViewframeWithKetboard));
}

- (void)setZy_fallHight:(CGFloat)fallHight {
    objc_setAssociatedObject(self, @selector(zy_fallHight), @(fallHight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_fallHight {
    return [objc_getAssociatedObject(self, @selector(zy_fallHight))floatValue];
}
@end
