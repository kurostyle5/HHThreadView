//
//  CellActionsView.m
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import "HHCollapsiblePostCellActionsView.h"

@interface HHCollapsiblePostCellActionsView ()

@property (nonatomic) NSArray *actionButtons;

@end

@implementation HHCollapsiblePostCellActionsView

+ (instancetype) viewWithActionButtons:(NSArray*)actionButtons size:(CGSize)size {
    HHCollapsiblePostCellActionsView *view = [[HHCollapsiblePostCellActionsView alloc] init];
    view.actionButtons = actionButtons;
    for (UIButton *button in view.actionButtons) {
        [view addSubview:button];
    }
    CGRect viewFrame = view.frame;
    viewFrame.size = size;
    view.frame = viewFrame;
    return view;
}

- (void) layoutSubviews {
    NSUInteger numberOfButtons = self.actionButtons.count;
    if (numberOfButtons == 0) {
        return;
    }
    
    // Quick math. Center the buttons based on dividing this view by numberOfButtons + 1. It's cool.
    CGFloat buttonCenterX = self.frame.size.width / (numberOfButtons + 1);
    CGFloat buttonCenterY = self.frame.size.height / 2;
    
    for (int i = 0; i < numberOfButtons; ++i) {
        UIButton *button = self.actionButtons[i];
        button.center = CGPointMake(buttonCenterX * (i + 1), buttonCenterY);
        
        CGRect frame = button.frame;
        frame.size = CGSizeMake(buttonCenterX, buttonCenterX);
        button.frame = frame;
    }
}

@end
