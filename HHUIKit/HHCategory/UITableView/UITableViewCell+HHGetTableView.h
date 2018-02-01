//
//  UITableViewCell+HHGetTableView.h
//  FunnyTicket
//
//  Created by Xun on 17/5/3.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (HHGetTableView)

@property (nonatomic, readonly, weak) UITableView *tableView;

/// 此方法需在Cell可见时才有用，否则可能无效哦，请慎用
@property (nonatomic, readonly, weak) NSIndexPath *indexPath;

@end
