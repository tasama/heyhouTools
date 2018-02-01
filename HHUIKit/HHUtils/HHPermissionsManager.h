//
//  HHPermissionsManager.h
//  FunnyTicket
//
//  Created by heyhou on 17/2/21.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface HHPermissionsManager : NSObject

+ (void)checkMicrophonePermissionsWithBlock:(void(^)(BOOL granted))block;
+ (void)checkCameraAuthorizationStaStusWithBlock:(void(^)(BOOL granted))block;
+ (void)checkAlbumAuthorizationStatusWithBlock:(void(^)(BOOL granted))block;
+ (void)checkAddressBookAuthorizationStatusWithBlock:(void(^)(BOOL granted, ABAddressBookRef addressBook))block;
+ (BOOL)isOpenGPS;

@end
