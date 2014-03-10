//
//  HHPostCell.h
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHPostCellActionsView;

@protocol HHPostProtocol;

/**
 The HHPostCell class represents a cell in a large table that contains a
 forum-style post and its children. Upon tapping the header, the view collapses itself 
 and all of its children.
 
 @since 1.0
 */
@interface HHPostCell : UIView

+ (instancetype) cellWithPost:(id<HHPostProtocol>)post;

@property (nonatomic) id<HHPostProtocol> post;

/**
 The number of indentations to apply to this cell.
 
 @since 1.0
 */
@property (nonatomic) NSInteger indentationLevel;

/**
 The width of each indentation. Smaller values mean you can fit more children in a thread without
 resorting to dots.
 
 @since 1.0
 */
@property (nonatomic) CGFloat indentationWidth;

/**
 The ActionsView of this cell. Ideally, this view contains 3-5 options for the user to do.
 
 @since 1.0
 */
@property (nonatomic, readonly) HHPostCellActionsView *actionsView;

/**
 The action buttons in the cell.
 
 @since 1.0
 */
@property (nonatomic) NSMutableArray *actionButtons;

/**
 If the cell is collapsed, it shows only the header button, grayed out.
 
 @since 1.0
 */
@property (nonatomic, getter = isCollapsed) BOOL collapsed;

@end
