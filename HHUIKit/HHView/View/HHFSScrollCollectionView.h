//
//  HHFSScrollCollectionView.h
//  FunnyTicket
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    moveStateIdty,
    moveStateDragging
    
} HHFSScrollCollectionViewMoveState;

@interface HHFSScrollCollectionView : UICollectionView

@property (nonatomic, assign) HHFSScrollCollectionViewMoveState oldState;

@end
