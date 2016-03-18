//
//  OpenRankViewController.m
//  m2048
//
//  Created by linxiaolong on 16/3/10.
//  Copyright © 2016年 Danqing. All rights reserved.
//

#import "OpenRankViewController.h"
#import "OpenRankConfig.h"



@interface OpenRankViewController ()<UIWebViewDelegate>
@property(nonatomic, retain) UIWebView *webView;

@end

@implementation OpenRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    [self initWebView];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]
                                initWithTitle:@"返回"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:@selector(closeSelf)];
//    [leftBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"STHeitiSC-Light" size:16], NSFontAttributeName,nil]
//                           forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBtn;
//    [leftBtn release];
//    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 50, 50)];
//    closeBtn.layer.cornerRadius = 25;
//    closeBtn.backgroundColor = [UIColor blackColor];
//    [closeBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:closeBtn];
}

-(void)closeSelf{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    NSLog(@"%@",[NSString stringWithFormat:@"http://openrank.duapp.com/index.php?c=rank&a=ShowRankHtml&user_openid=%@&app_id=%@&score_score=%@",openid,appId,score]);
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
