//
//  HHCommentThreadView.h
//  CSH News
//
//  Created by Harlan Haskins on 2/5/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHPostProtocol;

@interface HHThreadScrollView : UIScrollView

@property (nonatomic, readonly) NSMutableArray *allCells;

+ (instancetype) threadViewWithPosts:(NSArray*)posts;
+ (instancetype) threadViewWithPosts:(NSArray*)posts actions:(NSMutableArray*)actionButtons;

@end
