//
//  VFResizableTableViewHeader.m
//  VFResizableTableViewHeaderDemo
//
//  Created by HS on 7/27/16.
//  Copyright © 2016 Vincent. All rights reserved.
//

#import "VFResizableTableViewHeader.h"
#import "Marcoes.h"


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
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self createSubviews];
    }
    
    return self;
}

- (void)dealloc {
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
        if (contentOffset.y < -self.initialHeight - 64.f) {
            CGRect frame = self.backgroundImageView.frame;
            CGFloat height = - contentOffset.y;
            DebugLog(@"%lf", height);
            frame.size.height = height;
            // Aligned background image view's bottom with bottom of its superview
            frame.origin.y = self.initialHeight - height;
            self.backgroundImageView.frame = frame;
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
