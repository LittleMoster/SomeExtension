//
//  AppDelegate+Extension.m
//  UICategory
//
//  Created by cguo on 2017/5/15.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "WXApi.h"
#import <objc/runtime.h>
#import <objc/message.h>
//新浪微博SDK头文件
#import "WeiboSDK.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "OpenShare+Alipay.h"
#import "OpenShare+Weixin.h"
// 腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//Jpush相关的头文件
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end
@implementation AppDelegate (Extension)

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

+(void)load
{

    
    
}


+(void)Chengeperform
{
    //运行时交换方法
    //didFinishLaunchingWithOptions方法交换
    
    Method application= class_getInstanceMethod([self class], @selector(application:didFinishLaunchingWithOptions:));
    
    Method JQapplication= class_getInstanceMethod([self class], @selector(JQapplication:JQdidFinishLaunchingWithOptions:));
    
    method_exchangeImplementations(application, JQapplication);
    
    
    
    
    //交换jpush注册成功时的方法
    Method didRegister= class_getClassMethod([UIResponder class], @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:));
    
    Method JQdidRegister= class_getClassMethod([UIResponder class], @selector(JQapplication:didRegisterForRemoteNotificationsWithDeviceToken:));
    
    method_exchangeImplementations(didRegister, JQdidRegister);
    
    //交换添加处理APNs通知回调方法
    
    
    //交换jpush注册成功时的方法
    Method didReceiveRemote= class_getClassMethod([UIResponder class], @selector(application:didReceiveRemoteNotification:fetchCompletionHandler:));
    
    Method JQdidReceiveRemote= class_getClassMethod([UIResponder class], @selector(JQapplication:didReceiveRemoteNotification:fetchCompletionHandler:));
    
    method_exchangeImplementations(didReceiveRemote, JQdidReceiveRemote);
    
    Method RemoteNotification= class_getClassMethod([UIResponder class], @selector(application:didReceiveRemoteNotification:));
    
    Method JQRemoteNotification= class_getClassMethod([UIResponder class], @selector(JQapplication:didReceiveRemoteNotification:));
    
    method_exchangeImplementations(RemoteNotification, JQRemoteNotification);
    
    
    
}

- (void)JQapplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self JQapplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)JQapplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [self JQapplication:application didReceiveRemoteNotification:userInfo];
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)JQapplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self JQapplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    //JPush成功会回调设备名称
     [JPUSHService registerDeviceToken:deviceToken];
}





- (BOOL)JQapplication:(UIApplication *)application JQdidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self JQapplication:application JQdidFinishLaunchingWithOptions:launchOptions];
    
    //shareSDK第三方配置
    [self initShareSDK];
    
    [self initPushSDK];
#if DEBUG
    BOOL isProduction = NO;
#else
    BOOL isProduction = YES;
#endif
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_KEY channel:JPUSH_CHANCEL apsForProduction:isProduction];
    
    return YES;
}
- (void)init3Part{
    [OpenShare connectAlipay];//支付宝
    [OpenShare connectWeixinWithAppId:WeiXinSDK_AppId];//微信
//    [AMapServices sharedServices].apiKey = AMAP_KEY;//高德地图
}
// iOS 10 Support


//第三方登陆和分享
#pragma mark - ShareSDK配置
- (void)initShareSDK
{
    
    [ShareSDK registerApp:ShareSDK_Key
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:SinaSDK_AppId
                                           appSecret:SinaSDK_Secret
                                         redirectUri:SDKredirectUri
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeiXinSDK_AppId
                                       appSecret:WeiXinSDK_Secret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQSDK_AppId
                                      appKey:QQSDK_Secret
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    [WXApi registerApp:WeiXinSDK_AppId];
}

-(void)initPushSDK
{
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];

    }

}

@end
