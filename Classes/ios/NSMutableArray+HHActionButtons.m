//
//  NSMutableArray+HHActionButtons.m
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import "NSMutableArray+HHActionButtons.h"
#import "UIColor+HHPostCellColors.h"

@implementation NSMutableArray (HHActionButtons)

- (void) HH_addActionButtonWithImage:(UIImage*)image
                              target:(id)target
                            selector:(SEL)selector {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image
            forState:UIControlStateNormal];
    
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [button addTarget:target
               action:selector
     forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    [self addObject:button];
}

@end
