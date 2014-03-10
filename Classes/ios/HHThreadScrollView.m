//
//  HHThreadScrollView.m
//  CSH News
//
//  Created by Harlan Haskins on 2/5/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import "HHThreadScrollView.h"
#import "HHPostCell.h"
#import "HHPostProtocol.h"

@interface HHThreadScrollView ()

@property (nonatomic) HHPostCell *parentCell;
@property (nonatomic) NSArray *posts;
@property (nonatomic) BOOL laidOutSubviews;

@property (nonatomic, readwrite) NSMutableArray *allCells;
@property (nonatomic) NSMutableArray *actionButtons;

@end

@implementation HHThreadScrollView

+ (instancetype) threadViewWithPosts:(NSArray*)posts {
    return [self threadViewWithPosts:posts actions:nil];
}

+ (instancetype) threadViewWithPosts:(NSArray*)posts actions:(NSMutableArray*)actionButtons {
    HHThreadScrollView *threadView = [HHThreadScrollView new];
    threadView.posts = posts;
    threadView.actionButtons = actionButtons;
    [threadView addAllCellsAsSubviews];
    return threadView;
}

- (void) setPosts:(NSArray *)posts {
    _posts = posts;
}

- (void) addAllCellsAsSubviews {
    self.allCells = [NSMutableArray array];
    for (int i = 0; i < self.posts.count; i++) {
        HHPostCell *cell = [HHPostCell cellWithPost:self.posts[i]];
        [self.allCells addObject:cell];
        [self addSubview:cell];
    }
}

- (void) setNeedsLayout {
    self.laidOutSubviews = NO;
    [super setNeedsLayout];
}

- (void) layoutSubviews {
    if (!self.laidOutSubviews) {
        CGFloat sidePadding = 0.0;
        CGFloat widthWithSidePadding = self.frame.size.width - (sidePadding * 2.0);
        CGSize comparisonSize = CGSizeMake(widthWithSidePadding, CGFLOAT_MAX);
        CGFloat previousHeight = 0;
        CGFloat previousY = 0;
        for (int i = 0; i < self.allCells.count; i++) {
            HHPostCell *cell = self.allCells[i];
            
            CGFloat originY =
            previousY = previousY + previousHeight;
            
            CGFloat estimatedHeight =
            previousHeight = [cell sizeThatFits:comparisonSize].height;
            
            CGRect cellRect = CGRectZero;
            cellRect.origin = CGPointMake(sidePadding, originY);
            cellRect.size = CGSizeMake(widthWithSidePadding, estimatedHeight);
            cell.frame = cellRect;
            
            if (self.actionButtons && !cell.actionButtons) {
                cell.actionButtons = self.actionButtons;
            }
        }
        self.laidOutSubviews = YES;
        [self reloadContentSize];
    }
}

- (void) setFrame:(CGRect)frame {
    self.laidOutSubviews = NO;
    [super setFrame:frame];
}

- (void) reloadContentSize {
    UIView *lastCollapsibleCell = [self.allCells lastObject];
    self.contentSize = CGSizeMake(self.frame.size.width, lastCollapsibleCell.frame.origin.y + lastCollapsibleCell.frame.size.height);
}

@end
