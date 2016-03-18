//
//  OpenRankController.h
//  m2048
//
//  Created by linxiaolong on 16/3/18.
//  Copyright © 2016年 Danqing. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol OpenRankControllerDelgate

-(void)loginSuccess;
-(void)loginError;

@end
@interface OpenRankController : NSObject
@property (nonatomic,assign)id<OpenRankControllerDelgate> delegate;

+ (OpenRankController *)getinstance;


/**
 *  静态方法，调用本方法在window上弹出在线排行榜
 *  参数：
 *      score       ->玩家的最新高分， 服务端会对本分数进行判断，如果低于旧分数不会更新
 *
 */
-(void)showRankForScore:(NSString*)score;

/**
 *  登录用户数据   注：openrank目前只存储开发者提供的用户数据（包括第三方：QQ，微博，微信等），不单独提供新用户注册系统
 *  参数：
 *      openId      ->用户的唯一id
 *      appId       ->在官网注册的appId
 *      nickName    ->玩家昵称
 *      headUrl     ->玩家头像连接 注：QQ，微博，微信等sdk登录后都会提供头像连接，如果您的用户没有头像连接请传 @"" 值
 *      score       ->玩家的最新高分， 服务端会对本分数进行判断，如果低于旧分数不会更新
 *
 */
-(void)loginForOpenId:(NSString *)openId appId:(NSString *)appId nickName:(NSString *)nickName headUrl:(NSString *)headUrl loginBackBlock:(void(^)(BOOL loginBack))backCallBlock;

/**
 *
 *  是否已登录，未登录需要调用  登录用户数据 方法
 *
 */
-(BOOL)isLogin;

/**
 *
 *  清空指定AppId下的所有服务器数据
 ⚠️注意：本方法一旦调用服务器上的排行榜数据将清空，请谨慎使用
 *
 */
-(void)cleanOpenRankForAppId:(NSString*)appId;
@end
