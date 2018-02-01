//
//  UIImage+Data.m
//  AFNetworking
//
//  Created by xheng on 9/11/17.
//

#import "UIImage+JPEGData.h"

@implementation UIImage (JPEGData)

- (NSData *)imageData
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    
    if (data.length > 100 * 1024)
    {
        if (data.length > 1024 * 1024)
        {//1M以及以上
            data=UIImageJPEGRepresentation(self, 0.1);
        }
        else if (data.length > 512 * 1024)
        {//0.5M-1M
            data=UIImageJPEGRepresentation(self, 0.5);
        }
        else if (data.length > 200 * 1024)
        {//0.25M-0.5M
            data=UIImageJPEGRepresentation(self, 0.9);
        }
    }
    return data;
}


@end
