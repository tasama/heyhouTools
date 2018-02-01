//
//  HHBasicViewController.m
//  Heyhou
//
//  Created by XiaoZefeng on 24/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import "HHBasicViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "HHNoDataView.h"
#import "HHNoContentView.h"
#import "HHAlertView.h"
#import "HHRefreshView.h"
#import "HHPostDisableView.h"
#import "UIView+Frame.h"
#import <HHFoundation/HHLogSystem.h>
#import <objc/runtime.h>
#import <HHMarco.h>


@interface HHBasicViewController ()<UIAlertViewDelegate, HHAlertViewDelegate> //
{
    UIBarButtonItem *_addFriendItem;
}

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@end

@implementation HHBasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationItem setHidesBackButton:YES];
    if ([self.navigationController.viewControllers count] > 1)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"navigationbar_back_btn_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutMsg) name:HHUSERACCOUNT_DIDLOGIN_FROM_OTHERDEVICE object:nil];
}

//是否可以旋转
- (BOOL)shouldAutorotate
{
    return false;
}
//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)loginOutMsg {
    
    HHAlertView *alertView = [[HHAlertView alloc]initWithTitle:@"账号异常!" message:@"您的账号已经在另一个客户端登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    
    [alertView show];
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)getShowView
{
    return objc_getAssociatedObject(self, &viewKey);
}

- (UIView *)getPostDisAbleView {
    
    return objc_getAssociatedObject(self, @"postDisableView");
}
const char *viewKey;
- (void)showNoDataInView:(UIView *)view
{
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        nodataView = [[HHNoDataView alloc] initWithFrame:CGRectMake((view.zf_width - view.zf_width * .4) / 2.0f, view.zf_height * .5 - view.zf_width * .1 - 17.5, view.zf_width * .4, view.zf_width * .2 + 35)];
        objc_setAssociatedObject(self, &viewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == view) {
        [nodataView removeFromSuperview];
    }
    [view addSubview:nodataView];
}
- (void)showNoDataInView:(UIView *)view InRect:(CGRect)rect
{
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        nodataView = [[HHNoDataView alloc] initWithFrame:rect];
        objc_setAssociatedObject(self, &viewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == view) {
        [nodataView removeFromSuperview];
    }
    [view addSubview:nodataView];
}

- (void)showNoDataInView:(UIView *)view andMessage:(NSString *)message {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        nodataView = [[HHNoDataView alloc] initWithFrame:CGRectMake((view.zf_width - view.zf_width * .4) / 2.0f, view.zf_height * .5 - view.zf_width * .1 - 17.5, view.zf_width * .4, view.zf_width * .2 + 35)];
        objc_setAssociatedObject(self, &viewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    nodataView.message = message;
    if (nodataView.superview == view) {
        [nodataView removeFromSuperview];
    }
    [view addSubview:nodataView];
}

- (void)showNoDataInView:(UIView *)view andMessage:(NSString *)message andPlaceholderImg:(UIImage *)image InRect:(CGRect)rect {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        
        if (CGRectIsEmpty(rect)) {
            nodataView = [[HHNoDataView alloc] initWithFrame:view.bounds];
        } else {
            
            nodataView = [[HHNoDataView alloc] initWithFrame:view.bounds];
            nodataView.imageView.frame = rect;
        }
        
        objc_setAssociatedObject(self, &viewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == view) {
        [nodataView removeFromSuperview];
    }
    nodataView.message = message;
    nodataView.image = image;
    
    [view addSubview:nodataView];
}

- (void)hideNoDataView
{
    UIView *noDataView = [self getShowView];
    [noDataView removeFromSuperview];
}

- (void)showNoContentInView:(UIView *)view message:(NSString *)message
{
    HHNoContentView *noContentView = (HHNoContentView *)[self getShowView];
    if (!noContentView) {
        noContentView = [[HHNoContentView alloc] initWithFrame:view.bounds];
        objc_setAssociatedObject(self, &viewKey, noContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    noContentView.message = message;
    if (noContentView.superview == view) {
        [noContentView removeFromSuperview];
    }
    [view addSubview:noContentView];
}
- (void)showNoContentInView:(UIView *)view InRect:(CGRect)rect message:(NSString *)message
{
    HHNoContentView *noContentView = (HHNoContentView *)[self getShowView];
    if (!noContentView) {
        noContentView = [[HHNoContentView alloc] initWithFrame:rect];
        objc_setAssociatedObject(self, &viewKey, noContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    noContentView.message = message;
    if (noContentView.superview == view) {
        [noContentView removeFromSuperview];
    }
    [view addSubview:noContentView];
}

- (void)hideNoContentView
{
    UIView *noContentView = [self getShowView];
    [noContentView removeFromSuperview];
}

- (void)showPostDisableInViewWithOutNav:(UIView *)view withMessage:(NSString *)message {
    
    HHPostDisableView *disView = (HHPostDisableView *)[self getPostDisAbleView];
    if (!disView) {
        
        disView = [[NSBundle mainBundle] loadNibNamed:@"HHPostDisableView" owner:nil options:nil].lastObject;
        objc_setAssociatedObject(self, @"postDisableView", disView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    disView.frame = view.bounds;
    disView.tipMessageString = message;
    [disView setBackBlock:^{
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    if (disView.superview == view) {
        
        [disView removeFromSuperview];
    }
    [view addSubview:disView];
}

- (void)hidePostDisableInViewWithOutNav {
    
    UIView *disView = [self getPostDisAbleView];
    [disView removeFromSuperview];
}

- (void)showRefreshInView:(UIView *)view didRefresh:(refreshData )completion
{
    HHRefreshView *refreshView = (HHRefreshView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!refreshView) {
        refreshView = [[HHRefreshView alloc] initWithFrame:view.bounds];
        objc_setAssociatedObject(self, &viewKey, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (refreshView.superview == view) {
        [refreshView removeFromSuperview];
    }
    if (completion) {
        refreshView.didRefresh = ^(){
            completion();
        };
    }
    [view addSubview:refreshView];
}
- (void)showRefreshInView:(UIView *)view InRect:(CGRect)rect didRefresh:(refreshData )completion
{
    HHRefreshView *refreshView = (HHRefreshView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!refreshView) {
        refreshView = [[HHRefreshView alloc] initWithFrame:rect];
        objc_setAssociatedObject(self, &viewKey, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (refreshView.superview == view) {
        [refreshView removeFromSuperview];
    }
    if (completion) {
        refreshView.didRefresh = ^(){
            completion();
        };
    }
    [view addSubview:refreshView];
}
- (void)hideRefreshView
{
    UIView *refreshView = [self getShowView];
    [refreshView removeFromSuperview];
}
#pragma mark - IM

- (void)setupUntreatedApplyCount
{
    
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
#pragma mark - IM相关
#if 0
- (void)playSoundAndVibration
{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval)
    {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        HHLogDebug(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    NSString *alertBody = nil;
    if (options.displayStyle == EMPushDisplayStyleMessageSummary)
    {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type)
        {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"[图片]", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"[位置]", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"[语音]", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"[视频]", @"Video");
            }
                break;
            default:
                messageStr = @"[未知类型]";
                break;
        }
        
        do {
            NSString *title = message.ext[kChatFromUserNick];//[[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
            if (message.chatType == EMChatTypeGroupChat)
            {
                NSDictionary *ext = message.ext;
                if (ext && ext[kGroupMessageAtList])
                {
                    id target = ext[kGroupMessageAtList];
                    if ([target isKindOfClass:[NSString class]])
                    {
                        if ([kGroupMessageAtAll compare:target options:NSCaseInsensitiveSearch] == NSOrderedSame)
                        {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                    else if ([target isKindOfClass:[NSArray class]])
                    {
                        NSArray *atTargets = (NSArray*)target;
                        if ([atTargets containsObject:[EMClient sharedClient].currentUsername])
                        {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                }
                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                for (EMGroup *group in groupArray)
                {
                    if ([group.groupId isEqualToString:message.conversationId])
                    {
                        title = [NSString stringWithFormat:@"%@(%@)", message.ext[kChatFromUserNick], group.subject];
                        break;
                    }
                }
            }
            else if (message.chatType == EMChatTypeChatRoom)
            {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
                NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
                NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
                if (chatroomName)
                {
                    title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
                }
            }
            
            alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        } while (0);
    }
    else
    {
        alertBody = @"您有一条信息";//NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    BOOL playSound = NO;
    if (!self.lastPlaySoundDate || timeInterval >= kDefaultPlaySoundInterval)
    {
        self.lastPlaySoundDate = [NSDate date];
        playSound = YES;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    NSString *title = message.ext[kChatFromUserNick];
    [userInfo setObject:title forKey:kConversationChatterNick];
    
    //发送本地推送
    if (NSClassFromString(@"UNUserNotificationCenter"))
    {
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        if (playSound)
        {
            content.sound = [UNNotificationSound defaultSound];
        }
        content.body = alertBody;
        content.userInfo = userInfo;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    }
    else
    {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = alertBody;
        notification.alertAction = NSLocalizedString(@"open", @"Open");
        notification.timeZone = [NSTimeZone defaultTimeZone];
        if (playSound)
        {
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        notification.userInfo = userInfo;
        
        //发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}


- (EMConversationType)conversationTypeFromMessageType:(EMChatType)type
{
    EMConversationType conversatinType = EMConversationTypeChat;
    switch (type) {
        case EMChatTypeChat:
            conversatinType = EMConversationTypeChat;
            break;
        case EMChatTypeGroupChat:
            conversatinType = EMConversationTypeGroupChat;
            break;
        case EMChatTypeChatRoom:
            conversatinType = EMConversationTypeChatRoom;
            break;
        default:
            break;
    }
    return conversatinType;
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo)
    {
        if ([self.navigationController.topViewController isKindOfClass:[HHChatViewController class]])
        {
            //            ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
            //            [chatController hideImagePicker];
        }
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[HHChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = userInfo[kConversationChatter];
                    HHChatViewController *chatViewController = (HHChatViewController *)obj;
                    if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        EMChatType messageType = [userInfo[kMessageType] intValue];
                        
                        chatViewController = [[HHChatViewController alloc]
                                              initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                        [chatViewController setHidesBottomBarWhenPushed:YES];
                        switch (messageType)
                        {
                            case EMChatTypeChat:
                            {
                                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                                for (EMGroup *group in groupArray)
                                {
                                    if ([group.groupId isEqualToString:conversationChatter])
                                    {
                                        chatViewController.title = group.subject;
                                        break;
                                    }
                                }
                                chatViewController.title = userInfo[kConversationChatterNick];
                            }
                                break;
                            default:
                                chatViewController.title = conversationChatter;
                                break;
                        }
                        [self.navigationController pushViewController:chatViewController animated:NO];
                    }
                    *stop= YES;
                }
            }
            else
            {
                HHChatViewController *chatViewController = nil;
                NSString *conversationChatter = userInfo[kConversationChatter];
                EMChatType messageType = [userInfo[kMessageType] intValue];
                chatViewController = [[HHChatViewController alloc]initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                [chatViewController setHidesBottomBarWhenPushed:YES];
                switch (messageType) {
                    case EMChatTypeGroupChat:
                    {
                        NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                        for (EMGroup *group in groupArray)
                        {
                            if ([group.groupId isEqualToString:conversationChatter])
                            {
                                chatViewController.title = group.subject;
                                break;
                            }
                        }
                    }
                        break;
                    default:
                        chatViewController.title = userInfo[kConversationChatterNick];
                        //chatViewController.title = conversationChatter;
                        break;
                }
                [self.navigationController pushViewController:chatViewController animated:NO];
            }
        }];
    }
}

- (void)didReceiveUserNotification:(UNNotification *)notification
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    if (userInfo)
    {
        if ([self.navigationController.topViewController isKindOfClass:[HHChatViewController class]]) {
            //            ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
            //            [chatController hideImagePicker];
        }
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[HHChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = userInfo[kConversationChatter];
                    HHChatViewController *chatViewController = (HHChatViewController *)obj;
                    if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        EMChatType messageType = [userInfo[kMessageType] intValue];
                        chatViewController = [[HHChatViewController alloc]
                                              initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                        switch (messageType)
                        {
                            case EMChatTypeChat:
                            {
                                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                                for (EMGroup *group in groupArray)
                                {
                                    if ([group.groupId isEqualToString:conversationChatter])
                                    {
                                        chatViewController.title = group.subject;
                                        break;
                                    }
                                }
                                chatViewController.title = userInfo[kConversationChatterNick];
                            }
                                break;
                            default:
                                chatViewController.title = conversationChatter;
                                break;
                        }
                        [self.navigationController pushViewController:chatViewController animated:NO];
                    }
                    *stop= YES;
                }
            }
            else
            {
                HHChatViewController *chatViewController = nil;
                NSString *conversationChatter = userInfo[kConversationChatter];
                EMChatType messageType = [userInfo[kMessageType] intValue];
                
                chatViewController = [[HHChatViewController alloc]
                                      initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                switch (messageType) {
                    case EMChatTypeGroupChat:
                    {
                        NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                        for (EMGroup *group in groupArray) {
                            if ([group.groupId isEqualToString:conversationChatter]) {
                                chatViewController.title = group.subject;
                                break;
                            }
                        }
                    }
                        break;
                    default:
                        //chatViewController.title = conversationChatter;
                        chatViewController.title = userInfo[kConversationChatterNick];
                        break;
                }
                [self.navigationController pushViewController:chatViewController animated:NO];
            }
        }];
    }
}
#endif
@end
