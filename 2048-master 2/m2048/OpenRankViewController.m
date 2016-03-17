//
//  OpenRankViewController.m
//  m2048
//
//  Created by linxiaolong on 16/3/10.
//  Copyright © 2016年 Danqing. All rights reserved.
//

#import "OpenRankViewController.h"
#import "OpenRankURLRequest.h"

#define OPENRANKISLOGIN @"OPENRANKISLOGIN" //是否已登录
#define openrankopenid @"openrankopenid"
#define openrankusername @"openrankusername"
#define openrankuserlogo @"openrankuserlogo"


@interface OpenRankViewController ()<UIWebViewDelegate>
@property(nonatomic, retain) UIWebView *webView;
@end

@implementation OpenRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWebView];
}

//登录注册
+(void)loginForOpenId:(NSString *)openId appId:(NSString *)appId nickName:(NSString *)nickName headUrl:(NSString *)headUrl{
 
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://openrank.duapp.com/index.php?c=user&a=login&user_openid=%@&app_id=%@&score_score=%@&user_name=%@&user_logo=%@",openId,appId,@"0",nickName,headUrl]];
    OpenRankURLRequest *request = [OpenRankURLRequest hnRrequestWithURL:url];
    [request URLRequestAsynchronouslyWithCompletionUsingBlock:^(BOOL isfinish,OpenRankURLRequest *request){
        if (isfinish) {
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:request.data options:NSJSONReadingAllowFragments error:&error];
            
            if (error) {
                
            }
            else{
                [[NSUserDefaults standardUserDefaults] setValue:nickName forKey:openrankusername];
                [[NSUserDefaults standardUserDefaults] setValue:openId forKey:openrankopenid];
                [[NSUserDefaults standardUserDefaults] setValue:headUrl forKey:openrankuserlogo];
                //设置已登录标示
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:OPENRANKISLOGIN];
            }
            
        }else{
        }
    }];
    
}

//显示排行版
+(void)showRankForOpenId:(NSString*)openId appId:(NSString*)appId score:(NSString*)score{
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    
    OpenRankViewController *openVC = [[OpenRankViewController alloc]init];
    [window.rootViewController presentViewController:openVC animated:YES completion:^{
    
    }];
}

+(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:OPENRANKISLOGIN];
}


+(void)cleanOpenRankForAppId:(NSString*)appId{
    
}


-(void)initWebView{
    
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
    
    if (!self.webView) {
        UIWebView *hnwebView = [[UIWebView alloc] init];
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
            hnwebView.frame = CGRectMake(0, 0, height, width);
        }else{
            hnwebView.frame = CGRectMake(0, 0, width, height);
        }
        hnwebView.delegate = self;
        self.webView = hnwebView;
        hnwebView.autoresizingMask = NO;
        
        [self.view addSubview:self.webView];
    }
    [self requestWithURL];
}

-(void)requestWithURL{
    //    self.statusbartype = [UIApplication sharedApplication].statusBarStyle;
    
    //    url = @"http://www.baidu.com";
    NSString *openid = [[NSUserDefaults standardUserDefaults]valueForKey:openrankopenid];
    NSString *appId = @"10000";
    NSString *score = @"123123123";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openrank.duapp.com/index.php?c=rank&a=ShowRankHtml&user_openid=%@&app_id=%@&score_score=%@",openid,appId,score]]];
    [self.webView loadRequest:request];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
