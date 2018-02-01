//
//  UITableView+ZFUtil.m
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import "UITableView+Create.h"
#import "HHUIConst.h"

@implementation UITableView (Create)

+ (UITableView *)tableViewWithDelegate:(id <UITableViewDelegate , UITableViewDataSource>)delegate {
        UITableView *tableView = [[UITableView alloc] init];
        [tableView setBackgroundColor:[UIColor whiteColor]];
        [tableView setDelegate:delegate];
        [tableView setDataSource:delegate];
        [tableView setTableFooterView:[UIView new]];
        [tableView setSeparatorColor:TableView_Bottom_LineColor];
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        return tableView;
}

@end
