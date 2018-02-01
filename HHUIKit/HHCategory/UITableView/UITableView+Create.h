//
//  UITableView+ZFUtil.h
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import <UIKit/UIKit.h>


@interface UITableView (Create)
    
+ (UITableView *)tableViewWithDelegate:(id <UITableViewDelegate, UITableViewDataSource> )delegate;

@end
