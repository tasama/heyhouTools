//
//  HHPermissionsManager.m
//  FunnyTicket
//
//  Created by heyhou on 17/2/21.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHPermissionsManager.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "HHAlertView.h"
#import <HHFoundation/HHConst.h>
@import Photos;

@interface HHPermissionsManager ()<HHAlertViewDelegate>

@end

@implementation HHPermissionsManager

+ (void)checkMicrophonePermissionsWithBlock:(void(^)(BOOL granted))block
{
    NSString *mediaType =  AVMediaTypeAudio;
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if(!granted){
            dispatch_async(dispatch_get_main_queue(), ^{
                
                HHAlertView *alert = [[HHAlertView alloc] initWithTitle:@"没有麦克风权限"
                                                                message:@"请在iPhone的“设置-隐私-麦克风”选项中，允许嘿吼访问你的麦克风"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"设置", nil];
             //   alert.delegate = self;
                [alert show];
            });
        }
        if(block != nil)
            block(granted);
    }];
}

+ (void)checkCameraAuthorizationStaStusWithBlock:(void(^)(BOOL granted))block
{
    NSString *mediaType = AVMediaTypeVideo;
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (!granted){
            //Not granted access to mediaType
            dispatch_async(dispatch_get_main_queue(), ^{
                HHAlertView *alert = [[HHAlertView alloc] initWithTitle:@"没有相机权限"
                                                                message:@"请在iPhone的“设置-隐私-相机”选项中，允许嘿吼访问你的相机"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"设置", nil];
                alert.delegate = self;
                [alert show];
            });
        }
        if(block)
            block(granted);
    }];
}

+ (void)checkAlbumAuthorizationStatusWithBlock:(void(^)(BOOL granted))block
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL granted;
        if (status == PHAuthorizationStatusAuthorized) {
            // 用户同意授权
            granted = YES;
        }else {
            // 用户拒绝授权
            dispatch_async(dispatch_get_main_queue(), ^{
                HHAlertView *alert = [[HHAlertView alloc] initWithTitle:@"没有相册权限"
                                                                message:@"请在iPhone的“设置-隐私-相册”选项中，允许嘿吼访问你的相册"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"设置", nil];
                alert.delegate = self;
                alert.tag = 100;
                [alert show];
            });
            granted = NO;
        }
        if(block)
            block(granted);
    }];
}

+ (void)checkAddressBookAuthorizationStatusWithBlock:(void (^)(BOOL, ABAddressBookRef))block {
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            CFErrorRef *error1 = NULL;
            //ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(YES, addressBookRef);
            });
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        CFErrorRef *error = NULL;
        //ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            block(YES, addressBookRef);
        });
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{

            block(NO, addressBookRef);
        });
    }
}

+ (BOOL)isOpenGPS {
    if ((([CLLocationManager locationServicesEnabled]) && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark  - HHAlertViewDelegate

+ (void)HHAlertView:(HHAlertView *_Nonnull)alertView clickedButtonAtIndex:(NSInteger )buttonIndex
{
    if (alertView.tag == 100) {
        
        if(buttonIndex == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    } else {
        
        if(buttonIndex == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        if (buttonIndex == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:HHPermissionsCancelNotification object:nil];
        }
    }
    
  
}



@end
