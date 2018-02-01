//
//  HHConst.h
//  FunnyTicket
//
//  Created by heyhou on 16/10/27.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHDefines.h"

typedef NS_ENUM(NSUInteger, HHFollowType) {
    HHFollowTypeBrand, //
    HHFollowTypeExpert,
    HHFollowTypeShow, // 活动
    HHFollowTypeTopic // 专题
};

typedef NS_ENUM(NSUInteger, HHMediaOperate) {
    HHMediaOperateLike, //
    HHMediaOperateCollection,
    HHMediaOperateDownload,
    HHMediaOperateShare,
    HHMediaOperateReward,
    HHMediaOperateSendBarrage,
    HHMediaOperateUnCollection
};

typedef NS_ENUM(NSUInteger, HHThemeBarType) {
    HHThemeBarTypeFollow, //
    HHThemeBarTypeCommet,
    HHThemeBarTypeShare,
};

typedef NS_ENUM(NSUInteger, HHAuthorityType) {
    HHAuthorityTypeLottery = 1,
    HHAuthorityTypeShake,
    HHAuthorityTypeCheckTicket
};

typedef NS_ENUM(NSUInteger, HHVideoDraftType) {
    HHVideoDraftTypeNormal,
    HHVideoDraftTypeRecord, // 录制页面非正常退出的存储类型
    HHVideoDraftTypePreview // 预览页面非正常退出的存储类型
};

typedef NS_ENUM(NSInteger, HHFTEffectType) {
    HHFTEffectTypeNone, // 没有特效
    HHFTEffectTypeFilter,   // 滤镜特效
    HHFTEffectTypeTime     // 时间特效
};

typedef NS_ENUM(NSInteger, HHEffectSpecificType) {
    HHEffectSpecificTypeNone, // 没有特效
    HHEffectSpecificTypeSoulFadeout = 1, // 灵魂出窍
    HHEffectSpecificTypeReverse = 10  // 时光倒流
};

typedef NS_ENUM(NSInteger, HHFTVideoDuration) { /** 录制时长 */
    HHFTVideoDuration15Sec, // 15s
    HHFTVideoDuration2Min  // 2min
};


typedef NS_ENUM(NSInteger, HHRSPlayStatus) { /** 录音棚各音轨状态 */
    HHRSPlayStatusAccompanyNone,
    HHRSPlayStatusAccompanyOnly,
    HHRSPlayStatusVocal1Only,
    HHRSPlayStatusVocal2Only,
};

/*
 *   全局的
 */
static NSString *locationTimer = @"UpdateLocationTimer";

/** 通讯录选择完成的通知 */
HH_EXTERN NSString *const HHAddressBookSelectedNotification;

/** 排行榜topType切换的通知 */
HH_EXTERN NSString *const HHChartsTopTypeChangedNotification;

/** 分类filterType切换的通知 */
HH_EXTERN NSString *const HHCagegoryFilterTypeChangedNotification;

/** 网络状态切换的通知 */
HH_EXTERN NSString *const HHNetWorkingChangedNotification;

/** 网络状态切换的通知 */
HH_EXTERN NSString *const HHInsertBarrageNotification;

/** 登录成功的通知 */
HH_EXTERN NSString *const HHLoginSuccessNotification;

/** 推出登录的通知 */
HH_EXTERN NSString *const HHLoginOutNotification;

/** 首页滚动到关注页面通知 */
HH_EXTERN NSString *const HHAttentionViewAppearNotification; //

/** 开始播放录制的音乐（如果还在播放，通知停止） */
HH_EXTERN NSString *const HHStartPlayRecordMusicNotification;

/** 视频页面横屏时点上退出键盘 */
HH_EXTERN NSString *const HHVideoEndEidtingNotification;

/** 竖屏时把模型信息告诉底部的view */
HH_EXTERN NSString *const HHVideoLandscapeModelSetNotification;

/** 竖屏时点击bottomView的btn */
HH_EXTERN NSString *const HHVideoLandscapeBtnClickNotification;

/** 视频播放按钮点击的通知，为控制弹幕的暂停 */
HH_EXTERN NSString *const HHVideoPlayBtnClickNotification; //

/** 点击开始下载音乐的通知 */
HH_EXTERN NSString *const HHDownloadMusicNotification;

/** */
HH_EXTERN NSString *const HHRewardViewDismissNotification;

/** 点击了删除按钮的通知*/
HH_EXTERN NSString *const HHClickDeleteBtnNotification;

/** 视频页面点击操作的通知*/
HH_EXTERN NSString *const HHMeidaOperateNotification;

/** 选择了背景音乐的通知 */
HH_EXTERN NSString *const HHChooseBackgroundAudio;

/** 个人秀音乐播放 */
HH_EXTERN NSString *const HHPersonShowMusicPlay;

/** 个人秀音乐播放 */
HH_EXTERN NSString *const HHPersonShowMusicStop;

/** 个人秀音乐播放 */
HH_EXTERN NSString *const HHPersonShowDeleteShow;

/** 停止播放音乐 */
HH_EXTERN NSString *const HHStopPlayFMNotification;

/** 播放音乐切换 */
HH_EXTERN NSString *const HHFMChageSongNotification;

/** 播放音乐切换 */
HH_EXTERN NSString *const HHFMCancleAllCollectionMusicNotification;

/** 重新加载视频 */
HH_EXTERN NSString *const HHVideoReloadNotification;


/** 个人主页停止播放个人秀 */
HH_EXTERN NSString *const HHStopPersonShowVideoNotification;

/** 扫描二维码的成功的通知 */
HH_EXTERN NSString *const HHScanQRCodeNotification;

/** 专题小视频播放通知 */
HH_EXTERN NSString *const HHThemeVideoPlayNotification;

/** 取消获取授权通知 */
HH_EXTERN NSString *const HHPermissionsCancelNotification;

/** 选择视频背景通知 */
HH_EXTERN NSString *const HHChooseAudioNotification;

/** 取消选择视频背景通知 */
HH_EXTERN NSString *const HHCancleChooseAudioNotification;

/** 选择视频通知 */
HH_EXTERN NSString *const HHChooseVideoNotification;

/** 发送视频横屏积分的通知 */
HH_EXTERN NSString *const HHSendVideoScoreModelNotification;

/** 增加了评论 */
HH_EXTERN NSString *const HHAddNewCommentNotification;

/** 从视频登陆 */
HH_EXTERN NSString *const HHVideoPlayerPushLoginNotification;

/** 进入横屏 */
HH_EXTERN NSString *const HHVideoPlayerChangePortraitNotification;

/** 重新播放，弹幕时间拉去时间制零 */
HH_EXTERN NSString *const HHVideoRePlayNotification;

/** 复制帖子二级评论的通知 */
HH_EXTERN NSString *const HHCopyPostSonCommentNotification;

/** 潮拍分享的通知 */
HH_EXTERN NSString *const HHFPShareNotification;


/** 潮拍更改滤镜的通知 */
HH_EXTERN NSString *const HHFilterTypeChangedNotification;

/** 潮拍更换道具的通知 */
HH_EXTERN NSString *const HHPropTypeChangedNotification;

/** 潮拍删除@好友的通知 */
HH_EXTERN NSString *const HHDeleteAtFriendNotification;

/** 开始上传视频的通知 */
HH_EXTERN NSString *const HHStartUploadVideoNotification;

/** 开始上传视频失败的通知 */
HH_EXTERN NSString *const HHUploadVideoFailedNotification;

/** 开始特效的通知 */
HH_EXTERN NSString *const HHStartVideoEffectNotification;

/** 停止特效的通知 */
HH_EXTERN NSString *const HHStopVideoEffectNotification;

/** 时间特效的通知 */
HH_EXTERN NSString *const HHVideoTimeEffectNotification;

/** 商务合作获取权限后的模型存储文件 */
HH_EXTERN NSString *const HHbusinessLevel;

/** 视频循环播放 */
HH_EXTERN NSString *const HHVideoCyclePlay;

/** 视频播放后台播放 */
HH_EXTERN NSString *const HHVideoBGPlay;

#pragma mark - 文件夹

/** 录制的音乐文件夹 */
HH_EXTERN NSString *const RecordFileName;

/**  */
HH_EXTERN NSString *const VoiceFileName;

/**录音+有背景音乐的混音文件夹 */
HH_EXTERN NSString *const ComposeFileName;

/** FM正在播放音乐在数组中的下标 */
HH_EXTERN NSString *const HHFMPlayingIndex;

/** FM正在播放音乐的Id */
HH_EXTERN NSString *const HHFMPlayingSongId;

/** 草稿箱分段录像 */
HH_EXTERN NSString *const DraftVideos;

/** 草稿箱音乐文件路径 */
HH_EXTERN NSString *const DraftMusics;

/** 草稿箱封面文件路径 */
HH_EXTERN NSString *const VideoCoverFolder;
/** 合成视频的路径 */
HH_EXTERN NSString *const CombineVideoFolder;
/** 音乐剪切的路径 */
HH_EXTERN NSString *const CutAudioFloder;
/** 录影棚文件路径 */
HH_EXTERN NSString *const AudioStudioFloder;

/** 录音棚第一次录制 */
HH_EXTERN NSString *const HHRSFirstRecord;
/** 录音棚第一次编辑 */
HH_EXTERN NSString *const HHRSFirstEdit;
/** 录音棚第一次Mute */
HH_EXTERN NSString *const HHRSFirstMute;
/** 录音棚第一次solo */
HH_EXTERN NSString *const HHRSFirstSolo;
/** 第一次进入App显示录制指引箭头*/
HH_EXTERN NSString *const HHRSFirstShowArrow;

/** 事件id */
static NSString *const HHEVENT_ID = @"eventId";
/** 事件时间 */
static NSString *const HHEVENT_TIME = @"eventTime";
/** 对象id */
static NSString *const HHEVENT_OBJECT = @"object";

/** 剪切声音速度 */
static NSString *const AudioSpeedSlower = @"AudioSpeedSlower";
/** 剪切声音速度 */
static NSString *const AudioSpeedSlow = @"AudioSpeedSlow";
/** 剪切声音速度 */
static NSString *const AudioSpeedFast = @"AudioSpeedFast";
/** 剪切声音速度 */
static NSString *const AudioSpeedFaster = @"AudioSpeedFaster";

static NSString *const HHLoginFromAnotherDevice = @"userAccountDidLoginFromOtherDevice";
