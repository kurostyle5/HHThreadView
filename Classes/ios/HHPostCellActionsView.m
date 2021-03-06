//
//  HHPostCellActionsView.m
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import "HHPostCellActionsView.h"
#import <QuartzCore/QuartzCore.h>

@interface HHPostCellActionsView ()

@property (nonatomic) NSArray *actionButtons;

// For some reason the frame gets overwritten to CGRectZero. We need to save a copy.
@property (nonatomic) CGRect savedFrame;

@end

@implementation HHPostCellActionsView

+ (instancetype) viewWithActionButtons:(NSArray*)actionButtons frame:(CGRect)frame {
    HHPostCellActionsView *view = [[HHPostCellActionsView alloc] init];
    view.actionButtons = actionButtons;
    view.savedFrame = frame;
    for (UIButton *button in view.actionButtons) {
        [view addSubview:button];
    }
    return view;
}

- (void) layoutSubviews {
    self.frame = self.savedFrame;
    
    NSUInteger numberOfButtons = self.actionButtons.count;
    if (numberOfButtons == 0) {
        return;
    }
    
    // Quick math. Center the buttons based on dividing this view by numberOfButtons + 1. It's cool.
    CGFloat sections = (CGFloat)(numberOfButtons + 1);
    CGFloat buttonCenterX = round(self.frame.size.width / sections);
    CGFloat buttonCenterY = round(self.frame.size.height / 2.0);
    
    for (int i = 0; i < numberOfButtons; ++i) {
        
        UIButton *button = self.actionButtons[i];
        
        CGRect buttonFrame = button.frame;
        CGFloat minSize = MIN(buttonFrame.size.height, buttonFrame.size.width);
        minSize = round(MIN(minSize, self.frame.size.height * 0.67));
        buttonFrame.size = CGSizeMake(minSize, minSize);
        button.frame = buttonFrame;

        button.center = CGPointMake(buttonCenterX * (i + 1), buttonCenterY);
    }
}

@end
