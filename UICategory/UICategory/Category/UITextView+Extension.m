//
//  UITextView+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UITextView+Extension.h"
#import <objc/runtime.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "NSAttributedString+Extension.h"
@implementation UITextView (Extension)

+ (void)load {
    [super load];
    
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}


-(BOOL)resignFirstResponder
{
    
    self.placeholderColor=self.zy_placeholderLabelColor;
    self.placeholderLabel.text=self.zy_placeholderStr;
    return [super resignFirstResponder];
}
-(BOOL)becomeFirstResponder
{
       self.tintColor=[UIColor clearColor];
    if (self.zy_placeholderLabelHeightColor!=nil) {
//        如果获得第一响应者就设置改变其颜色
    
        self.placeholderLabel.textColor=self.zy_placeholderLabelHeightColor;
    }if (self.zy_HeightLightplaceholder !=nil) {
            self.placeholderLabel.text=self.Heightlightplaceholder;
    }
   return  [super becomeFirstResponder];
}

- (void)swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
       if (self.zy_placeholderLabel) {//移除label
        for (NSString *key in self.class.observingKeys) {
            @try {
                [self removeObserver:self forKeyPath:key];
            }
            @catch (NSException *exception) {
                // Do nothing
            }
        }
    }
    [self swizzledDealloc];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)getInputTextNumWithBlock:(void (^)(int))block
{
//    [self rac_signalForSelector:@selector(textViewDidChange:) fromProtocol:UITextViewDelegate];
    
    [[self rac_textSignal]subscribeNext:^(id x) {
       int num= [self getInputTextNum];
        if (block) {
            block(num);
        }
        
        
    }];
}

-(int)getInputTextNum
{
    NSString *content = [NSMutableString stringWithString:self.textStorage.string];
    NSStringEncoding GBKEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSUInteger width = [content lengthOfBytesUsingEncoding:GBKEncoding];
    if (width) {
        width = width % 2 == 0 ? width / 2 : width / 2 +1;
    }
 
    return (int)width ;
}
-(void)setHeightlightplaceholder:(NSString *)Heightlightplaceholder
{
    self.zy_HeightLightplaceholder=Heightlightplaceholder;
}
-(NSString *)Heightlightplaceholder
{
    return self.zy_HeightLightplaceholder;
}
-(void)setMaxTextNum:(int)MaxTextNum
{
    self.zy_MaxTextNum=MaxTextNum;
}
-(int)MaxTextNum
{
    return self.zy_MaxTextNum;
}

-(void)setZy_MaxTextNum:(int)num
{
    objc_setAssociatedObject(self, @selector(zy_MaxTextNum), @(num), OBJC_ASSOCIATION_ASSIGN);
}

-(int)zy_MaxTextNum
{
    return [objc_getAssociatedObject(self, @selector(zy_MaxTextNum))intValue];
}
#pragma mark - `observingKeys`

+ (NSArray *)observingKeys {
    return @[@"attributedText",
             @"bounds",
             @"font",
             @"frame",
             @"text",
             @"textAlignment",
             @"textContainerInset"];
}


#pragma mark - Properties
#pragma mark `placeholderLabel`
//添加成员属性--占位文字label
- (UILabel *)zy_placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, @selector(zy_placeholderLabel));
   
    return label;
}
-(void)setZy_placeholderLabel:(id)objc
{
    objc_setAssociatedObject(self, @selector(zy_placeholderLabel), objc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark `placeholder`

- (NSString *)placeholder {
    return self.zy_placeholderStr;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    self.zy_placeholderStr=placeholder;
    if(self.placeholderLabel==nil)
    {//如果为空就新建label
    self.placeholderLabel=[[UILabel alloc]init];
    }
    self.placeholderLabel.text = placeholder;
//    self.placeholderLabel.font=self.font;
    if (self.placeholderLabel.textColor==nil) {
          self.placeholderLabel.textColor=[UIColor grayColor];
    }
//
    
    [self setPlaceholderLabel:self.placeholderLabel];
//    [self updatePlaceholderLabel];
}

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel
{
    self.zy_placeholderLabel=placeholderLabel;
 
    if (placeholderLabel) {
        NSAttributedString *originalText = self.attributedText;
        self.text = @" "; // lazily set font of `UITextView`.
        self.attributedText = originalText;
        
       
        self.zy_placeholderLabel.numberOfLines = 0;
        self.zy_placeholderLabel.userInteractionEnabled = NO;
      
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceholderLabel)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        
        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    [self updatePlaceholderLabel];
}

-(UILabel *)placeholderLabel
{
    return  self.zy_placeholderLabel;
}

#pragma mark `placeholderColor`

- (UIColor *)placeholderColor {
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
     if(self.placeholderLabel==nil)
     {
    self.placeholderLabel=[[UILabel alloc]init];
     }
    self.placeholderLabel.textColor = placeholderColor;
//    self.placeholderLabel.font=self.font;
    
    [self setPlaceholderLabel:self.placeholderLabel];
    self.zy_placeholderLabelColor=placeholderColor;
}
-(void)setPlaceholderHeightlightColor:(UIColor *)placeholderHeightlightColor
{
    self.zy_placeholderLabelHeightColor=placeholderHeightlightColor;
}

-(UIColor *)placeholderHeightlightColor
{
    return self.zy_placeholderLabelHeightColor;
}

- (void)setZy_placeholderLabelColor:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderLabelColor), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIColor *)zy_placeholderLabelColor {
    return objc_getAssociatedObject(self, @selector(zy_placeholderLabelColor));
}

- (void)setZy_placeholderLabelHeightColor:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderLabelHeightColor), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIColor *)zy_placeholderLabelHeightColor {
    return objc_getAssociatedObject(self, @selector(zy_placeholderLabelHeightColor));
}

- (void)setZy_HeightLightplaceholder:(id)object {
    objc_setAssociatedObject(self, @selector(zy_HeightLightplaceholder), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString *)zy_HeightLightplaceholder {
    return objc_getAssociatedObject(self, @selector(zy_HeightLightplaceholder));
}

- (void)setZy_placeholderStr:(id)object {
    objc_setAssociatedObject(self, @selector(zy_placeholderStr), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSString *)zy_placeholderStr {
    return objc_getAssociatedObject(self, @selector(zy_placeholderStr));
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self updatePlaceholderLabel];
}


#pragma mark - Update

- (void)updatePlaceholderLabel {
    if (self.text.length) {
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    
    [self insertSubview:self.placeholderLabel atIndex:0];
    
//    self.placeholderLabel.font = self.font;
    self.placeholderLabel.textAlignment = self.textAlignment;
    
    // `NSTextContainer` is available since iOS 7
    CGFloat lineFragmentPadding;
    UIEdgeInsets textContainerInset;
    
#pragma deploymate push "ignored-api-availability"
    // iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        lineFragmentPadding = self.textContainer.lineFragmentPadding;
        textContainerInset = self.textContainerInset;
    }
#pragma deploymate pop
    
    // iOS 6
    else {
        lineFragmentPadding = 5;
        textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    }
    
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat y = textContainerInset.top;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
    self.placeholderLabel.frame = CGRectMake(x, y, width, height);
}

@end
