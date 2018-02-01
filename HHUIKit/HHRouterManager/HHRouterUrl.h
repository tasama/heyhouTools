//
//  HHRouterUrl.h
//  Pods
//
//  Created by tasama on 17/11/24.
//
//

#import <Foundation/Foundation.h>

@interface HHRouterUrl : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSDictionary *parameters;

- (instancetype)initWithUrl:(NSString *)url;

@end
