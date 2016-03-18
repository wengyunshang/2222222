//
//  OpenRankController.m
//  m2048
//
//  Created by linxiaolong on 16/3/18.
//  Copyright © 2016年 Danqing. All rights reserved.
//

#import "OpenRankController.h"
#import "OpenRankURLRequest.h"
#import "OpenRankViewController.h"
#import "OpenRankConfig.h"

static OpenRankController *g_instance = nil;

@interface OpenRankController ()
@property (nonatomic,retain) NSString *score;
@end

@implementation OpenRankController

+ (OpenRankController *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance){
            g_instance = [[super allocWithZone:nil] init];
        }
    }
    return g_instance;
}


//登录注册
-(void)loginForOpenId:(NSString *)openId appId:(NSString *)appId nickName:(NSString *)nickName headUrl:(NSString *)headUrl loginBackBlock:(void(^)(BOOL loginBack))backCallBlock{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://openrank.duapp.com/index.php?c=user&a=login&user_openid=%@&app_id=%@&score_score=%@&user_name=%@&user_logo=%@",openId,appId,@"0",nickName,headUrl]];
    OpenRankURLRequest *request = [OpenRankURLRequest hnRrequestWithURL:url];
    [request URLRequestAsynchronouslyWithCompletionUsingBlock:^(BOOL isfinish,OpenRankURLRequest *request){
        if (isfinish) {
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:request.data options:NSJSONReadingAllowFragments error:&error];
            
            if (error) {
             
                backCallBlock(NO);
            }else{
                
                [[NSUserDefaults standardUserDefaults] setValue:nickName forKey:openrankusername];
                [[NSUserDefaults standardUserDefaults] setValue:openId forKey:openrankopenid];
                [[NSUserDefaults standardUserDefaults] setValue:headUrl forKey:openrankuserlogo];
                //设置已登录标示
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:OPENRANKISLOGIN];
                
                backCallBlock(YES);
            }
            
        }else{
        }
    }];
    
}

-(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:OPENRANKISLOGIN];
}

//显示排行版
-(void)showRankForScore:(NSString*)score{
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    
    OpenRankViewController *openVC = [[OpenRankViewController alloc]init];
    openVC.score = score;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:openVC];
    [window.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)cleanOpenRankForAppId:(NSString*)appId{
    
}

@end
