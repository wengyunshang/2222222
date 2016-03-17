//
//  M2AppDelegate.h
//  m2048
//
//  Created by Danqing on 3/16/14.
//  Copyright (c) 2014 Danqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
#import <TencentOpenAPI/TencentApiInterface.h>
@interface M2AppDelegate : UIResponder <UIApplicationDelegate,GADInterstitialDelegate>
{
} 
@property (strong, nonatomic) UIWindow *window;
/// The interstitial ad.
@property(nonatomic, strong) GADInterstitial *interstitial;
@end
