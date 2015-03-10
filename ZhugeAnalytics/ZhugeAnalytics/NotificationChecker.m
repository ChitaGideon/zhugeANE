//
//  NotificationChecker.m
//  UmMessage
//
//  Created by Pamakids－Dev - Chita on 14-8-1.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "NotificationChecker.h"
static BOOL _launchedWithNotification = NO;
static NSDictionary *_localNotification = nil;
@implementation NotificationChecker
+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNotificationChecker:)
                                                 name:@"UIApplicationDidFinishLaunchingNotification" object:nil];

    
}

+ (void)createNotificationChecker:(NSNotification *)notification
{
    NSDictionary *launchOptions = [notification userInfo] ;
    
    // This code will be called immediately after application:didFinishLaunchingWithOptions:.
    NSDictionary *remoteNotification = [launchOptions objectForKey: @"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSLog(@"~~~~~~createNotificationChecker %@  ~~~~~~~~~~~\n  %@   ~~~~~~~~~\n    %@",notification ,launchOptions,  remoteNotification);
    if (launchOptions)
    {
        _launchedWithNotification = YES;
        _localNotification = launchOptions;
    }
    else
    {
        _launchedWithNotification = NO;
    }
}

+(BOOL) applicationWasLaunchedWithNotification
{
    return _launchedWithNotification;
}

+(NSDictionary*) getlaunchOptions
{
    return _localNotification;
}
@end
