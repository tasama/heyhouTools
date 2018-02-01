//
//  HHMarco.h
//  Pods
//
//  Created by xheng on 7/11/17.
//

#ifndef HHMarco_h
#define HHMarco_h
#import <Foundation/Foundation.h>

#define kAppleReviewDemoAccount @"6621"        // 苹果审核DEMO帐号:16000000000, 嘿吼ID:6621
#define LoadPageCount   20
#define TicketUrl   [NSString stringWithFormat:@"%@ticket.html?from=top",H5_Front_Url]//?hide_nav_bar=yes

#define MessageBoxUnReadDictKey @"messageBoxUnReadDictionary"
#define HTMLLocalStorageKey @"HTMLLocalStorageKey"
#define CreatePostBarCircleCategoryKey @"PostBarCircleCategoryKey"

#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define NSLog(...) printf("%f %s %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String],__func__);

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]//系统版本号

#define noticRecord [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"system_notification.plist"]

#define lastPlayRecord [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"lastPlay.plist"]
#define lastPlayRecordIndex [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"lastPlayIndex.plist"]
#define cacheBanner [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"cacheBanner.plist"]
#define cacheTopThree [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"cacheTopThree.plist"]
#define cacheLiveData(ID) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"cacheLiveData_%zd.plist", ID]]
#define cacheCateGory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"cacheCateGory"]

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standard UserDefaults]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//用户偏好设置中存储的KEY
#define HHUserAccount @"HHUserAccount" //用户账户信息（uid和token）
#define HHIsLogin @"HHIsLogin"  //登录状态判定
#define HHUSERACCOUNT_DIDLOGIN_FROM_OTHERDEVICE @"userAccountDidLoginFromOtherDevice" //登录状态被挤掉

//偏好设置存取
#define userDefaulrSet(obj,key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define userDefaulGet(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define kIslogin(login) userDefaulrSet(@(login), HHIsLogin);


#define DELETE_FRIENDS [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteFriend" object:nil]
#define ADD_DELETE_FRIENDS [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"deleteFriend" object:nil]

#define RELOAD_FRIENDS [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadFriend" object:nil]
#define ADD_RELOAD_FRIENDS [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"reloadFriend" object:nil]

//视频存储路径
#define KVideoUrlPath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]

#endif /* HHMarco_h */
