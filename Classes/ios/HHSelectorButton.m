//
//  HHSelectorButton.m
//  Pods
//
//  Created by Harlan Haskins on 3/12/14.
//
//

#import "HHSelectorButton.h"

@interface HHSelectorButton ()

@property (nonatomic, readwrite) NSSet *allActions;
@property (nonatomic, readwrite) SEL action;

@end

@implementation HHSelectorButton

- (void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [super addTarget:target action:action forControlEvents:controlEvents];
    self.action = action;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
