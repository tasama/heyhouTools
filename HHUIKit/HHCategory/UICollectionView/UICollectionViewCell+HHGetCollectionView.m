//
//  UICollectionViewCell+HHGetCollectionView.m
//  FunnyTicket
//
//  Created by Xun on 17/5/3.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UICollectionViewCell+HHGetCollectionView.h"

@implementation UICollectionViewCell (HHGetCollectionView)

- (UITableView *)tableView {
    
    return [self responderOfClass:[UICollectionView class]];
}

- (UIResponder *)responderOfClass:(Class)class {
    
    UIResponder *nextResponder = [self nextResponder];
    
    while (nextResponder) {
        
        if ([nextResponder isKindOfClass:class]) {
            
            break;
        }
        
        nextResponder = [nextResponder nextResponder];
    }
    
    return nextResponder;
}

@end
