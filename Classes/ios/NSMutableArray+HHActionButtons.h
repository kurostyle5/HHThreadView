//
//  NSMutableArray+HHActionButtons.h
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (HHActionButtons)

- (void) HH_addActionButtonWithImage:(UIImage*)image
                              target:(id)target
                            selector:(SEL)selector;

@end
