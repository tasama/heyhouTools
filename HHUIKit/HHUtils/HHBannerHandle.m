//
//  HHBannerHandle.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 11/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHBannerHandle.h"
#import <HHFoundation/HHLogSystem.h>
#import <HHFoundation/HHClickAction.h>
#import "HHRouterManager.h"
#import <HHFoundation/HHMarco.h>

@implementation HHBannerHandle

#pragma mark - scrollviewdelegate && bannerDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_bannerView scroll];
}

- (void)bannerView:(HHBannerView *)view didSelectAtIndex:(NSInteger)index
{
    if (_superVC == nil) {
        return;
    }
    if ([view.dataSource isKindOfClass:[NSArray class]]) {
        if ([view.dataSource count] <= index) {
            return;
        }
        id dic = view.dataSource[index];
        if ([dic isKindOfClass:[NSDictionary class]]) {
            NSString *protocolValue = dic[@"protocol"];
            HHLogDebug(@"protocol : %@",protocolValue);
            if (!kStringIsEmpty(protocolValue)) {
                
                [HHClickAction event:@"banner.click" andObject:@{@"id": dic[@"bannerId"]}];
                [HHRouterManager openUrl:protocolValue with:_superVC.navigationController andAnimation:YES];
                
                return;
            }
        }
    }
}

@end
