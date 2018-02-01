//
//  HHVipHead.h
//  FunnyTicket
//
//  Created by tasama on 17/9/11.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHVipHead : UIView

+ (HHVipHead *)userIcon;

- (void)hh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *_Nullable)image;

@property (nonatomic, assign) BOOL showVipIcon;

@end
