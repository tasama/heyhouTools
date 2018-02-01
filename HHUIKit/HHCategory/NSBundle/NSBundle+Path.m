//
//  NSBundle+Path.m
//  Pods
//
//  Created by xheng on 9/11/17.
//

#import "NSBundle+Path.h"

@implementation NSBundle (Path)

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths lastObject];
    return docDir;
}

@end
