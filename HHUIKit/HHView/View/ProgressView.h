//
//  ProgressView.h
//  progressTest
//
//  Created by tasama on 16/10/14.
//  Copyright © 2016年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    ProgressViewCircleType,
    ProgressViewLineType
    
}ProgressViewType;

@interface ProgressView : UIView

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) ProgressViewType type;

@property (nonatomic, strong) UIColor *fillColor;

@end
