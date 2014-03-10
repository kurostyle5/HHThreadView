//
//  HHPostCellActionsView.h
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 HHCPostCellActionsView is a UIView that positions a set of UIButtons inside an HHPostCell, accessible with a swipe.
 */
@interface HHPostCellActionsView : UIView

+ (instancetype) viewWithActionButtons:(NSArray*)actionButtons frame:(CGRect)frame;

@end
