//
//  constant.h
//  NMT
//
//  Created by Bhavesh on 31/08/15.
//  Copyright (c) 2015 Haresh  Vavadiya. All rights reserved.
//

#ifndef NMT_constant_h
#define NMT_constant_h


#define ALERT_TITLE @"Shy7lo"
#define defaults [NSUserDefaults standardUserDefaults]
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_WIDESCREEN ( ( double )[ [ UIScreen mainScreen ] bounds ].size.height == ( double )568 )
#define IS_IPHONE_5 ( IS_WIDESCREEN )
#define IS_IPAD UIDevice.currentDevice().userInterfaceIdiom

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define auth_userName @""
#define auth_password @""

#define COMMAND @"command"
#define SUCCESS @"status"
#define DEVICE_TOKEN @"device_token"
#define IS_LOGIN @"is_login"
#define MSG_NO_INTERNET @"Internet connection not available"


#define customObj [[customClassViewController alloc]init]
#define splashObj [[splashViewController alloc]init]

#define headerColor [UIColor colorWithRed:7/255.0 green:109/255.0 blue:135/255.0 alpha:1]
#define statusBarColor [UIColor colorWithRed:98/255.0 green:63/255.0 blue:45/255.0 alpha:1]
#define grayColor [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]
#define lightGrayColor [UIColor colorWithRed:197/255.0 green:195/255.0 blue:195/255.0 alpha:1]
#define orangeColor [UIColor colorWithRed:238/255.0 green:126/255.0 blue:38/255.0 alpha:1]

#define font_Montserrat  @"Montserrat"
#define font_Montserrat_Semibold  @"Montserrat-SemiBold"

#define pink 235 31 85
#define switch 67 31 71
#define purple_bg 43 22 45
#define lightgrayBg 235 235 235
#define grayText 42 42 42 

//#define API_URL @"http://192.168.0.100/vexel/api/"
#define API_URL @"https://api.shy7lo.com"     //https://api.shylabs.com
#define BANNER_URL @"https://portal.shy7lo.com"   //https://portal.shylabs.com


#define IMAGE_URL @"http://mage2.shy7lo.com/media/catalog/product/"
#define IMAGE_URL_CART @"http://mage2.shy7lo.com/media/catalog/product"
//#define API_URL @"http://www.prioritiiapp.com/api/"

#endif
/*
 orange: 238 126 38
 dark blue: 7 109 135
 register: 78 141 157
 lite grey: 197 195 195
 time: 173 173 173
 i'm hosting an...: 58 45 62
 lite blue chat: 96 173 193*/
