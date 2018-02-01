//
//  HHRouterUrl.m
//  Pods
//
//  Created by tasama on 17/11/24.
//
//

#import "HHRouterUrl.h"

@implementation HHRouterUrl

- (instancetype)initWithUrl:(NSString *)url {
    
    if (self = [super init]) {
        
        self.url = url;
    }
    return self;
}

- (void)setParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSString class]]) {
            
            NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)obj,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
            [dict addEntriesFromDictionary:@{key: decodedString}];
            
        } else {
            
            [dict addEntriesFromDictionary:@{key:obj}];
        }
    }];
    _parameters = dict.copy;
}

@end
