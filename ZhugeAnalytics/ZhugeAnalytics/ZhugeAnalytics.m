//
//  ZhugeAnalytics.m
//  ZhugeAnalytics
//
//  Created by Pamakids－Dev - Chita on 15-2-10.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "ZhugeAnalytics.h"
#import "FlashRuntimeExtensions.h"
#import "Zhuge.h"
@implementation ZhugeAnalytics
//empty delegate functions, stubbed signature is so we can find this method in the delegate
//and override it with our custom implementation
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{}
//
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{}
@end
FREContext myCtx = nil;

//custom implementations of empty signatures above. Used for push notification delegate implementation.
void didRegisterForRemoteNotificationsWithDeviceToken(id self, SEL _cmd, UIApplication* application, NSData* deviceToken)
{
    NSString* tokenString = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is: %@", deviceToken);
    
//    [UMessage registerDeviceToken:deviceToken];
     [[Zhuge sharedInstance] registerDeviceToken:deviceToken];
    if ( myCtx != nil )
    {
        tokenString = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
       
        FREDispatchStatusEventAsync(myCtx, (uint8_t*)"TOKEN_SUCCESS", (uint8_t*)[tokenString UTF8String]);
    }
}

//custom implementations of empty signatures above. Used for push notification delegate implementation.
void didFailToRegisterForRemoteNotificationsWithError(id self, SEL _cmd, UIApplication* application, NSError* error)
{
    
    NSString* tokenString = [NSString stringWithFormat:@"Failed to get token, error: %@",error];
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError :%@" , tokenString);
    if ( myCtx != nil )
    {
        FREDispatchStatusEventAsync(myCtx, (uint8_t*)"TOKEN_FAIL", (uint8_t*)[tokenString UTF8String]);
    }
}

//custom implementations of empty signatures above. Used for push notification delegate implementation.
void didReceiveRemoteNotification(id self, SEL _cmd, UIApplication* application,NSDictionary *userInfo)
{
    [[Zhuge sharedInstance] handleRemoteNotification:userInfo];
    //    if ( myCtx != nil )
    //    {
    //        NSString *stringInfo = [AirPushNotification convertToJSonString:userInfo];
    //        if (application.applicationState == UIApplicationStateActive)
    //        {
    //            FREDispatchStatusEventAsync(myCtx, (uint8_t*)"NOTIFICATION_RECEIVED_WHEN_IN_FOREGROUND", (uint8_t*)[stringInfo UTF8String]);
    //        }
    //        else if (application.applicationState == UIApplicationStateInactive)
    //        {
    //            FREDispatchStatusEventAsync(myCtx, (uint8_t*)"APP_BROUGHT_TO_FOREGROUND_FROM_NOTIFICATION", (uint8_t*)[stringInfo UTF8String]);
    //        }
    //        else if (application.applicationState == UIApplicationStateBackground)
    //        {
    //            FREDispatchStatusEventAsync(myCtx, (uint8_t*)"APP_STARTED_IN_BACKGROUND_FROM_NOTIFICATION", (uint8_t*)[stringInfo UTF8String]);
    //        }
    //    }
}

FREObject onResume(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //不需要
    return nil;
}

FREObject onPause(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //不需要
    return nil;
}
FREObject beginEvent(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* str;
    uint32_t stringLength1;
    FREGetObjectAsUTF8(argv[0], &stringLength1, &str);
//    [MobClick beginEvent:[NSString stringWithUTF8String:(char*)str]];
    return nil;
}
FREObject endEvent(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* str;
    uint32_t stringLength1;
    FREGetObjectAsUTF8(argv[0], &stringLength1, &str);
//    [MobClick endEvent:[NSString stringWithUTF8String:(char*)str]];
    return nil;
}
FREObject beginLogPageView(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* str;
    uint32_t stringLength1;
    FREGetObjectAsUTF8(argv[0], &stringLength1, &str);
//    [MobClick beginLogPageView:[NSString stringWithUTF8String:(char*)str]];
    return nil;
}
FREObject endLogPageView(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* str;
    uint32_t stringLength1;
    FREGetObjectAsUTF8(argv[0], &stringLength1, &str);
//    [MobClick endLogPageView:[NSString stringWithUTF8String:(char*)str]];
    return nil;
}

FREObject startAnaly(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* appKey;
    const uint8_t* channelID;
    const uint8_t* version;
    uint32_t isLog;
    uint32_t isDebug;
    uint32_t stringLength;
    NSString *appKeyString = nil;
    NSString *channelIDString = nil;
    NSString *versionString = nil;
    Zhuge *zhuge = [Zhuge sharedInstance];

    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &appKey) == FRE_OK)){
        appKeyString = [NSString stringWithUTF8String:(char*)appKey];
    }
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &channelID) == FRE_OK)){
        channelIDString = [NSString stringWithUTF8String:(char*)channelID];
    }
    if(argv[2] && (FREGetObjectAsUTF8(argv[2], &stringLength, &version) == FRE_OK)){
        versionString = [NSString stringWithUTF8String:(char*)version];
    }
    if(argv[3] && (FREGetObjectAsBool(argv[3], &isLog) == FRE_OK)){
        NSLog(@"打开SDK日志打印  %u",isLog);
        if(isLog)
        {
//            [MobClick setLogEnabled:YES];
            // 打开SDK日志打印
            
            [zhuge.config setLogEnabled:YES]; // 默认关闭
        }
    }
    if(argv[4] && (FREGetObjectAsBool(argv[3], &isDebug) == FRE_OK)){
        NSLog(@"打开SDK DEBUG模式  %u",isDebug);
        if(isDebug)
        {
            // 打开SDK调试打印
            
            [zhuge.config setDebug:YES]; // 默认关闭
        }
    }
    
       // 自定义应用版本
    if ([versionString isEqualToString:@""]||[versionString isEqual:nil]) {
        [zhuge.config setAppVersion:channelIDString]; // 默认是@"App Store"
    }

//    [zhuge.config setAppVersion:@"0.9-beta"]; // 默认是info.plist中CFBundleShortVersionString值
    
    // 自定义渠道
    if ([channelIDString isEqualToString:@""]||[channelIDString isEqual:nil]) {
        [zhuge.config setChannel:channelIDString]; // 默认是@"App Store"
    }
    
    // 开启行为追踪
    NSDictionary * dic = [NotificationChecker getlaunchOptions];
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [zhuge registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound |
                                                        UIUserNotificationTypeAlert)
                                            categories:nil];
    } else {
        [zhuge registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                        UIRemoteNotificationTypeSound |
                                                        UIRemoteNotificationTypeAlert)
                                            categories:nil];
    }
#else
    [zhuge.push registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                    UIRemoteNotificationTypeSound |
                                                    UIRemoteNotificationTypeAlert)
                                        categories:nil];
#endif
    [zhuge startWithAppKey:appKeyString launchOptions:dic];
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithAppkey:appKeyString reportPolicy:(ReportPolicy) REALTIME channelId:channelIDString];
//    [MobClick updateOnlineConfig];
    
    NSLog(@"Called Init Function Finished In Zhuge, AppKey: %@ ChannelID: %@ dic:%@", appKeyString, channelIDString,dic);
    
    return nil;
}



FREObject identify(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"identify begin?");
    const uint8_t* eventID;
    const uint8_t* eventLabel;
    uint32_t stringLength1;
    uint32_t stringLength2;
    
    FREGetObjectAsUTF8(argv[0], &stringLength1, &eventID);
    FREGetObjectAsUTF8(argv[1], &stringLength2, &eventLabel);
    
    
    NSLog(@"Called identify Function, eventID: %s , eventLabel: %s",eventID, eventLabel);
    NSError *err =nil;
    NSMutableDictionary *dictionary =nil;
    if(eventLabel != NULL)
    {
        //        [MobClick event:[NSString stringWithUTF8String:(const char *)eventID] label:[NSString stringWithUTF8String:(const char *)eventLabel]];
        
        dictionary =  [NSJSONSerialization JSONObjectWithData:[[NSString stringWithUTF8String:(const char *)eventLabel] dataUsingEncoding: NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
        [[Zhuge sharedInstance] identify:[NSString stringWithUTF8String:(const char *)eventID] properties: dictionary];
    }
    
    NSLog(@"Called identify Function OK  %@ dic: %@",err,dictionary);
    
    return nil;
}
FREObject onEvent(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"onEvent begin?");
    const uint8_t* eventID;
    const uint8_t* eventLabel;
    uint32_t stringLength1;
    uint32_t stringLength2;
    
    FREGetObjectAsUTF8(argv[0], &stringLength1, &eventID);
    FREGetObjectAsUTF8(argv[1], &stringLength2, &eventLabel);
    
    
    NSLog(@"Called onEvent Function, eventID: %s , eventLabel: %s",eventID, eventLabel);
    NSError *err =nil;
    NSMutableDictionary *dictionary = nil;
    if(eventLabel != NULL)
    {
//        [MobClick event:[NSString stringWithUTF8String:(const char *)eventID] label:[NSString stringWithUTF8String:(const char *)eventLabel]];
         dictionary= [NSJSONSerialization JSONObjectWithData:[[NSString stringWithUTF8String:(const char *)eventLabel] dataUsingEncoding: NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        [[Zhuge sharedInstance] track:[NSString stringWithUTF8String:(const char *)eventID] properties: dictionary];
    }
    NSLog(@"Called onEvent Function OK err: %@ ,  dic: %@    == %@ ",err,dictionary.description,dictionary);
    
    return nil;
}

void ZhugeContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest,
                             const FRENamedFunction** functionsToSet){
    uint numOfFun = 10;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * numOfFun);
    *numFunctionsToTest = numOfFun;
    
    
    //injects our modified delegate functions into the sharedApplication delegate
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    Class objectClass = object_getClass(delegate);
    
    NSString *newClassName = [NSString stringWithFormat:@"Custom_%@", NSStringFromClass(objectClass)];
    Class modDelegate = NSClassFromString(newClassName);
    if (modDelegate == nil) {
        // this class doesn't exist; create it
        // allocate a new class
        modDelegate = objc_allocateClassPair(objectClass, [newClassName UTF8String], 0);
        
        SEL selectorToOverride1 = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
        
        SEL selectorToOverride2 = @selector(application:didFailToRegisterForRemoteNotificationsWithError:);
        
        SEL selectorToOverride3 = @selector(application:didReceiveRemoteNotification:);
        
        // get the info on the method we're going to override
        Method m1 = class_getInstanceMethod(objectClass, selectorToOverride1);
        Method m2 = class_getInstanceMethod(objectClass, selectorToOverride2);
        Method m3 = class_getInstanceMethod(objectClass, selectorToOverride3);
        
        // add the method to the new class
        class_addMethod(modDelegate, selectorToOverride1, (IMP)didRegisterForRemoteNotificationsWithDeviceToken, method_getTypeEncoding(m1));
        class_addMethod(modDelegate, selectorToOverride2, (IMP)didFailToRegisterForRemoteNotificationsWithError, method_getTypeEncoding(m2));
        class_addMethod(modDelegate, selectorToOverride3, (IMP)didReceiveRemoteNotification, method_getTypeEncoding(m3));
        
        // register the new class with the runtime
        objc_registerClassPair(modDelegate);
    }
    // change the class of the object
    object_setClass(delegate, modDelegate);
    
    func[0].name = (const uint8_t*) "startAnaly";
    func[0].functionData = NULL;
    func[0].function = &startAnaly;
    
    func[1].name = (const uint8_t*) "onEvent";
    func[1].functionData = NULL;
    func[1].function = &onEvent;
    
    func[2].name = (const uint8_t*) "getUDID";
    func[2].functionData = NULL;
    func[2].function = &onPause;
    
    func[3].name = (const uint8_t*) "onPause";
    func[3].functionData = NULL;
    func[3].function = &onPause;
    
    func[4].name = (const uint8_t*) "onResume";
    func[4].functionData = NULL;
    func[4].function = &onResume;
    
    
    func[5].name = (const uint8_t*) "beginLogPageView";
    func[5].functionData = NULL;
    func[5].function = &beginLogPageView;
    
    
    func[6].name = (const uint8_t*) "endLogPageView";
    func[6].functionData = NULL;
    func[6].function = &endLogPageView;
    
    func[7].name = (const uint8_t*) "onEventBegin";
    func[7].functionData = NULL;
    func[7].function = &beginEvent;
    
    func[8].name = (const uint8_t*) "onEventEnd";
    func[8].functionData = NULL;
    func[8].function = &endEvent;
    
    func[9].name = (const uint8_t*) "identify";
    func[9].functionData = NULL;
    func[9].function = &identify;
    
    *functionsToSet = func;
    
    NSLog(@"Inited");
}

void ZhugeExtFinalizer(void* extData)
{
    NSLog(@"Finalize!");
    return;
}

void ZhugeExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ZhugeContextInitializer;
    *ctxFinalizerToSet = &ZhugeExtFinalizer;
}
