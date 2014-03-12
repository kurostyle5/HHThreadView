//
//  HHSelectorButton.h
//  Pods
//
//  Created by Harlan Haskins on 3/12/14.
//
//

#import <UIKit/UIKit.h>

@interface HHSelectorButton : UIButton

@property (nonatomic, readonly) NSSet *allActions;
@property (nonatomic, readonly) SEL action;

@end
