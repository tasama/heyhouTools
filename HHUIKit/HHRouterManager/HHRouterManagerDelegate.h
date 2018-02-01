//
//  HHRouterManagerDelegate.h
//  Pods
//
//  Created by tasama on 17/11/24.
//
//

#ifndef HHRouterManagerDelegate_h
#define HHRouterManagerDelegate_h

@class HHRouterUrl;
@protocol HHRouterManagerSourceDelegate <NSObject>

- (id)viewControllerWithUrl:(HHRouterUrl *)url;


/**
 控制器回调的通用代理

 @param controllerTag 控制器的tag
 @param dictory       回调参数
 */
- (void)viewControllerTag:(NSString *)controllerTag withParameters:(NSDictionary *)dictory;

@end


#endif /* HHRouterManagerDelegate_h */
