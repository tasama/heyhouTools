//
//  HHUIMarco.h
//  Pods
//
//  Created by xheng on 7/11/17.
//

#ifndef HHUIMarco_h
#define HHUIMarco_h

#define APPDIDENTERBACKGROUNDKEY    @"appDidEnterBackground"
#define AppDidBecomeActiveNoti @"applicationDidBecomeActive"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define ScalePercent [UIScreen mainScreen].bounds.size.width / 375.0f

#define ScreenWidthScale (CGFloat )(UIScreen.mainScreen.bounds.size.width / 375)//适配宽度
#define ScreenHeightScale (CGFloat)(UIScreen.mainScreen.bounds.size.height / 667)

//定义UIImage对象 //<<<
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
//定义UIImage对象 //<<<
#define ImageNamed(A) [UIImage imageNamed:A]

//状态栏高度 //<<<
#define STATUS_BAR_HEIGHT 20
//NavBar高度 //<<<
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度 //<<<
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#pragma mark - placeholderImage //<<<
//placeholderimage
#define PlaceholderImage ImageNamed(@"placeHolderForFs") //常用默认背景图
#define HeadPlaceholderImage ImageNamed(@"headerNormalPlaceholder") //头像默认背景图
#define fs_placeholderImage ImageNamed(@"placeHolderForFs") //潮拍播放页专用默认背景图

#define RightArrowImage @"me_youjian"
#define TableView_Bottom_LineColor [UIColor colorWithWhite:1.0 alpha:.1]

/*-------------------------- XH --------------------------*/

#define ThemeTextColor [UIColor colorWithHexString:@"ffffff" alpha:.5]
#define ThemeTextColorLight [UIColor colorWithHexString:@"ffffff" alpha:0.8]


#define ViewWidth self.view.bounds.size.width
#define ViewHeight self.view.bounds.size.height

/*-------------------------- RH --------------------------*/

#define SEARCHVIEW_DISMISS @"searchView_dismiss"

#define WIFIENABLE @"wifiWatchEnable"

#define MUSIC_STARTPLAY @"music_startPlay"
#define MUSIC_STOPPLAY @"music_stopPlay"
#define MUSIC_CHANGE_SONG @"music_change_song"
#define HHFMChageMenuNotification @"HHFMChageMenuNotification"
#define HHNextSongNotification @"nextSongNotification"

#define HHFindFreidNOtification @"relaodclearData"
#define HHFindActivityNOtification @"relaodclearActivityData"

//#define H5_Front_Url @"http://tm.heyhou.com/"//@"http://192.168.1.115/"//http://lm.heyhou.com //<<<
#define giftKey @"133e6826b8b5bbdb4c3a9f396f65b1e4" //礼物的MD5Key
#define JUMP_TO_CHEATROOM @"jumpToChatRoom"

#define REVOLVE @"revolveScreen" // 屏幕旋转
#define HH_BATTLE_TIMEOUT @"battle_timeout" //倒计时结束

//尺寸伸缩的适配 //<<<
#define WIDTH_SCALE SCREEN_WIDTH / 375.0
#define HEIGHT_SCALE SCREEN_HEIGHT / 677.0

#define JUMP_TO_ADDNEWFRIEND_VC @"jump_to_addNewFriend_VC"

#define textCornerRadius 5 * heightSale

//导航条显示或隐藏 //<<<
#define navBarStatus(status) [self.navigationController setNavigationBarHidden:status animated:YES]
#define customFont [UIFont systemFontOfSize:15]
#define themeBackgroundColor [UIColor colorWithHexString:@"05101c"]
#define insecentColor [UIColor colorWithHexString:@"121c28"]

// RGB颜色 //<<<
#define HHColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];

//主体颜色 //<<<
#define themeColor [UIColor colorWithHexString:@"f33f40" alpha:1.0] //主题色（红色）
#define placeholderColor [UIColor colorWithHexString:@"ffffff" alpha:.2]

#define MidTextFont [UIFont systemFontOfSize:12]

#define heightSale (SCREEN_HEIGHT / 667.0)
/** cell的背景色*/
#define CellBGColor HHColor(15, 21, 30)
/** cell细节的字体色*/
#define CellDetailTextColor HHColor(112, 114, 119)
/** cell分割线颜色色*/
#define CellSeparateColor HHColor(32, 40, 50);

typedef void(^Callback)(id object);

#define customCellHeight 60

//网络错误提示
#define ERRORMSG [HHAlert showAlertString:@"网络异常,请检查网络"];
//不认识的错误码提示
#define OtherError [HHAlert showAlertString:[NSString stringWithFormat:@"网络异常%zd",ret]];

#define HHThumbnail 0

//七牛图片缩略图设置
#define QiNiuPhotoThumbnailMinSize @"?imageMogr2/auto-orient/thumbnail/100x"
#define QiNiuPhotoThumbnailMediumSize @"?imageMogr2/auto-orient/thumbnail/300x"
#define QiNiuPhotoThumbnailMaxSize @"?imageMogr2/auto-orient/thumbnail/660x"
#define QiNiuPhotoThumbnailBlur @"?imageMogr2/thumbnail/660x/blur/50x20/interlace/1/format/jpg"

/*------------------------- -------------------------- NEWHEYHOU ------------------------- --------------------------*/

#define HH_THEME_BACKGROUNDCOLOR [UIColor colorWithHexString:@"ffffff"]
#define HH_MAINTITLE_COLOR [UIColor colorWithHexString:@"333333"]
#define HH_SUBTITLE_COLOR [UIColor colorWithHexString:@"999999"]

#define LEFT_INSET 10

#define hUSERAGECONFIGKEY @"hh_userAgeConfig"//用户年龄段配置表->字典 name:tagId

#define kFont(size) [UIFont systemFontOfSize:(size)]
#define kBFont(size) [UIFont boldSystemFontOfSize:(size)]
#define kFontWithWeight(size, _weight) [UIFont systemFontOfSize:size weight:(_weight)]

// 视频item列数
#define Item_RowNum 2.0
// 视频item宽度
#define Video_Item_Width ((SCREEN_WIDTH - (Item_RowNum + 1) * Item_Padding) / Item_RowNum)
// 视频item宽高比
#define Video_Item_Scale  198 / 333.0
// 视频item ImageView高度
#define Video_Item_ImgHeight Video_Item_Width * Video_Item_Scale

// 关注视频ImageView宽高比
#define Attention_Video_Scale 370/ 650.0
// 关注视频ImageView宽度
#define Attention_Video_Width (SCREEN_WIDTH - Attention_Cell_LeftPadding - Attention_Cell_RightPadding)
// 视频item ImageView高度
#define Attention_Video_Height Attention_Video_Width * Attention_Video_Scale

/** 关注Tablvewhead Img的宽度 */
#define Attention_HeadImgHeight  (SCREEN_WIDTH - Attention_Cell_LeftPadding - Attention_Cell_RightPadding - (Attention_HeadNum - 1) * Attention_HeadMagin) / Attention_HeadNum
/**关注Tablvewhead头部的总高度 */
#define Attention_HeadHeight  2 * Attention_HeadTopMagin + Attention_NameLabelH + Attention_HeadImgHeight

#define EnCodeingFile(file) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:file]


#define RecordFile(file) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:file]

#define CachFile(file) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:file]
#define DownloadMusic @"downloadMusic"

#define KRemixDownloadSuccess @"KRemixDownloadSuccess"

#define NormalBGColor @"121C28"
#define VideoFrameWidth 540
#define VideoFrameHeight 960

#define currentNavPushTo(VC) HHTabBarViewController *tab = [[UIApplication sharedApplication].keyWindow rootViewController];\
HHNavigationController *nav = tab.selectedViewController;\
[nav pushViewController:VC animated:YES];


#endif /* HHUIMarco_h */
