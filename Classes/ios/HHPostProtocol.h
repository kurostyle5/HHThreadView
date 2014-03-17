//
//  HHPostProtocol.h
//  CSH News
//
//  Created by Harlan Haskins on 2/5/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HHPostProtocol <NSObject>

/**
 Text in the header section of the cell. Typically an author or post date.
 */
@property (nonatomic) NSString *headerText;

/**
 Text in the body of the post. Usually, well, the body.
 */
@property (nonatomic) NSString *bodyText;

@optional

/**
 Subject of the post.
 */
@property (nonatomic) NSString *subject;

/**
 Board of the post.
 */
@property (nonatomic) NSString *board;

/**
 The depth of the current post.
 */
@property (nonatomic) NSInteger depth;

/**
 The number of the current post.
 */
@property (nonatomic) NSInteger number;

/**
 An NSAttributedString representation of the body.
 */
@property (nonatomic) NSAttributedString *attributedBody;

/**
 A BOOL that tells whether the post is starred.
 */
@property (nonatomic, getter = isStarred) BOOL starred;

/**
 The ActionButtons of each cell.
 */
@property (nonatomic) NSMutableArray *actionButtons;

@end
