//
//  FileOwner.m
//  LoadNibViewDemo
//
//  Created by Haven on 7/2/14.
//  Copyright (c) 2014 LF. All rights reserved.
//

#import "FileOwner.h"

@implementation FileOwner
+(id)viewFromNibNamed:(NSString*) nibName {
    FileOwner *owner = [self new];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    if (arr && [arr isKindOfClass:[NSArray class]]) {
        return [arr firstObject];
    }
    else
    {
        return nil;
    }
}
@end
