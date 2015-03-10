//
//  NotificationChecker.h
//  UmMessage
//
//  Created by Pamakids－Dev - Chita on 14-8-1.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationChecker : NSObject
+ (void)load;
+ (void)createNotificationChecker:(NSNotification *)notification;
+(BOOL) applicationWasLaunchedWithNotification;
+(NSDictionary*) getlaunchOptions;
@end
