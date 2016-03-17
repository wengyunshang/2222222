//
//  SDKController.m
//  m2048
//
//  Created by linxiaolong on 16/3/16.
//  Copyright © 2016年 Danqing. All rights reserved.
//

#import "SDKController.h"
#import "sdkCall.h"
#import "OpenRankViewController.h"

#define APPID @"10000"

static SDKController *g_instance = nil;
@implementation SDKController

+ (SDKController *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[sdkCall alloc] init];
            
            g_instance = [[super allocWithZone:nil] init];
        }
    }
    
    return g_instance;
}
 
 //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[sdkCall getinstance]];

//登录
-(void)login{
    
    
    if (![OpenRankViewController isLogin]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[sdkCall getinstance]];
        NSArray* permissions = [NSArray arrayWithObjects:
                                kOPEN_PERMISSION_GET_USER_INFO,
                                kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                kOPEN_PERMISSION_ADD_ALBUM,
                                kOPEN_PERMISSION_ADD_ONE_BLOG,
                                kOPEN_PERMISSION_ADD_SHARE,
                                kOPEN_PERMISSION_ADD_TOPIC,
                                kOPEN_PERMISSION_CHECK_PAGE_FANS,
                                kOPEN_PERMISSION_GET_INFO,
                                kOPEN_PERMISSION_GET_OTHER_INFO,
                                kOPEN_PERMISSION_LIST_ALBUM,
                                kOPEN_PERMISSION_UPLOAD_PIC,
                                kOPEN_PERMISSION_GET_VIP_INFO,
                                kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                                nil];
        //执行QQ登录
        [[[sdkCall getinstance] oauth] authorize:permissions inSafari:NO];
    }else{
        //执行显示排行榜
        [OpenRankViewController showRankForOpenId:[[sdkCall getinstance]oauth].openId appId:APPID score:@"222222"];
    }
    
}

//获取QQ用户信息后上传到openrank
//其他第三方同样的原理
- (void)analysisResponse:(NSNotification *)notify
{
    [[NSNotificationCenter defaultCenter] removeObserver:kGetUserInfoResponse];
    // 登录
    [OpenRankViewController loginForOpenId:[[sdkCall getinstance]oauth].openId
                                     appId:APPID
                                  nickName:[sdkCall getinstance].nickname
                                   headUrl:[sdkCall getinstance].logo];
}
@end
