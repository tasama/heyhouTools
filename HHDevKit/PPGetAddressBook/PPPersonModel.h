//
//  PPAddressModel.h
//  PPAddressBook
//
//  Created by AndyPang on 16/8/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

/*
 *********************************************************************************
 *
 * 如果您在使用 PPGetAddressBook 的过程中出现bug或有更好的建议,还请及时以下列方式联系我,我会及
 * 时修复bug,解决问题.
 *
 * Weibo : CoderPang
 * Email : jkpang@outlook.com
 * QQ    : 2406552315
 * GitHub: https://github.com/jkpang
 *
 * PS:我的另外两个很好用的封装,欢迎使用!
 * 1.对AFNetworking 3.x 与YYCache的二次封装,一句代码搞定数据请求与缓存,告别FMDB:
 *   GitHub:https://github.com/jkpang/PPNetworkHelper
 * 2.仿京东淘宝商品数量的加减按钮,可定制程度高,使用简单:
 *   GitHub:https://github.com/jkpang/PPNumberButton
 *
 *********************************************************************************
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PPPersonModel : NSObject

/** 联系人姓名*/
@property (nonatomic, copy) NSString *name;
/** 联系人电话数组,因为一个联系人可能存储多个号码*/
@property (nonatomic, strong) NSMutableArray *mobileArray;
/** 联系人头像*/
@property (nonatomic, strong) UIImage *headerImage;

@property (nonatomic,copy) NSString *firstPhoneNum;

@property (nonatomic,assign,getter=isChoosed) BOOL choosed;


@end
