//
//  AppDelegate+Extension.h
//  UICategory
//
//  Created by cguo on 2017/5/15.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "AppDelegate.h"
//appid appkey
#define ShareSDK_Key @"1b296a7bade00"//shareSDK的分享秘钥，请去shareSDK官网申请

//新浪
#define SinaSDK_AppId @"3157501495"
#define SinaSDK_Secret @"a8b47e1d3cfebadfd02cf2871042a5f8"


//qq分享
#define QQSDK_AppId @"101377805"
#define QQSDK_Secret @"e96edad569f5fb1ec2bfb7af8e97412a"
//微信分享
#define WeiXinSDK_AppId @"wx09ba7cc082d6a5bc"
#define WeiXinSDK_Secret @"169c40d3e575dee054de7095c67f6ef2"
//地图key  要与相应的bundle id相对应   去高德地图申请key
#define AMAP_KEY @"422fcc018e0d8520f52f8663a274e60f"//原ts的bundle id 对应的
//#define AMAP_KEY @"d8384d826bedb5342b7ebcc3247b97bb"
//极光推送
#define JPUSH_KEY @"b8ad46c408b1d2bf5aba5f57"
#define JPUSH_CHANCEL @"6c0b5c2e10b4419999c37dd2"
// bugHD key
#define BUGHD_KEY @"f5906304e7d85640c041459768754dc4"

//app分享出去的回调地址
#define SDKredirectUri @"http://ms.yonxin.com"

#define APP_ID @""
@interface AppDelegate (Extension)


- (void)initShareSDK;
@end
