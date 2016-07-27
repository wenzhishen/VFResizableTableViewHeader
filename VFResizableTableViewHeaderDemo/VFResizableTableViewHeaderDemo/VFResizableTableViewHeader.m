//
//  VFResizableTableViewHeader.m
//  VFResizableTableViewHeaderDemo
//
//  Created by HS on 7/27/16.
//  Copyright © 2016 Vincent. All rights reserved.
//

#import "VFResizableTableViewHeader.h"


@interface VFResizableTableViewHeader ()
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic) CGFloat initialHeight;
@end

@implementation VFResizableTableViewHeader
- (instancetype)initWithTableView:(UITableView *)tableView initialHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(0, -height, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
    if (self) {
        self.tableView = tableView;
        self.initialHeight = height;
        self.clipsToBounds = YES;
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self createSubviews];
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.tableView removeObserver:self forKeyPath:@"contenOffset" context:nil];
}

- (void)createSubviews {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Stanford University"]];
    backgroundImageView.frame = self.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        CGPoint contentOffset = value.CGPointValue;
        NSLog(@"%lf", contentOffset.y);
        if (contentOffset.y < -self.initialHeight - 64.f) {
            CGRect frame = self.backgroundImageView.frame;
            frame.size.height = -contentOffset.y;
            self.backgroundImageView.frame = frame;
            // 保持Center不变
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
