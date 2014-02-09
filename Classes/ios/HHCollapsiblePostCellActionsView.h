//
//  CellActionsView.h
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 HHCollapsiblePostCellActionsView is a UIView that positions a set of UIButtons inside an HHCollapsiblePostCell, accessible with a swipe.
 */
@interface HHCollapsiblePostCellActionsView : UIView

+ (instancetype) viewWithActionButtons:(NSArray*)actionButtons size:(CGSize)size;

@end
