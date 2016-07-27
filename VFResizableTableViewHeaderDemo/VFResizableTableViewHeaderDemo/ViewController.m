//
//  ViewController.m
//  VFResizableTableViewHeaderDemo
//
//  Created by HS on 7/27/16.
//  Copyright © 2016 Vincent. All rights reserved.
//

#import "ViewController.h"
#import "VFResizableTableViewHeader.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

static NSString * const CellReuseID = @"cell reuse id";

#pragma mark - Life cycle
- (void)loadView {
    [super loadView];
    self.view = self.tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSStringFromClass([VFResizableTableViewHeader class]);
}

#pragma mark - UI
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseID];
        CGFloat initialHeight = 200.f;
        tableView.contentInset = UIEdgeInsetsMake(initialHeight, 0, 0, 0);
        VFResizableTableViewHeader *resizableHeader = [[VFResizableTableViewHeader alloc] initWithTableView:tableView initialHeight:initialHeight];
        [tableView addSubview:resizableHeader];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - Helpers

#pragma mark - Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 33;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row+ 1];
    return cell;
}

@end
