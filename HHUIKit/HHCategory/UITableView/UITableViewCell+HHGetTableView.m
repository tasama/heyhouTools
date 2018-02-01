//
//  UITableViewCell+HHGetTableView.m
//  FunnyTicket
//
//  Created by Xun on 17/5/3.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UITableViewCell+HHGetTableView.h"

@implementation UITableViewCell (HHGetTableView)

- (UITableView *)tableView {
    
    return [self responderOfClass:[UITableView class]];
}

- (NSIndexPath *)indexPath {
    
    if ([[self.tableView visibleCells] containsObject:self]) {
        
        return [self.tableView indexPathForRowAtPoint:self.center];
    }
    else {
        
        return nil;
    }
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
