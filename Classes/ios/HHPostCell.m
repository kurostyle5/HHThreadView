//
//  HHPostCell.m
//  CSH News
//
//  Created by Harlan Haskins on 2/4/14.
//  Copyright (c) 2014 Haskins. All rights reserved.
//

#import "HHPostCell.h"
#import "HHPostCellActionsView.h"
#import "HHPostProtocol.h"

@interface HHPostCell ()

@property (nonatomic, readwrite) HHPostCellActionsView *actionsView;
@property (nonatomic) BOOL actionButtonsVisible;

@property (nonatomic) UITextView *bodyView;
@property (nonatomic) UIButton *headerButton;

@property (nonatomic, readonly) NSString *headerText;

@property (nonatomic) NSMutableArray *lineViews;

@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic) CGFloat textViewHeight;

@end

@implementation HHPostCell

static const NSInteger MAX_INDENTATION_LEVEL = 6;
static const CGFloat ACTION_VIEW_HEIGHT = 34.0;

+ (instancetype) cellWithPost:(id<HHPostProtocol>)post {
    HHPostCell *cell = [HHPostCell new];
    
    [cell setPost:post];
    [cell adjustDepth];
    [cell createTextContainer];
    [cell createHeaderButton];
    [cell createTapRecognizer];
    
    return cell;
}

- (void) createTapRecognizer {
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnCell)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void) createTextContainer {
    self.bodyView = [UITextView new];
    self.bodyView.scrollEnabled = NO;
    self.bodyView.editable = NO;
    self.bodyView.selectable = YES;
    self.bodyView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.bodyView.opaque = YES;
    self.bodyView.backgroundColor =
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bodyView];
}

- (void) adjustDepth {
    self.indentationLevel = 0;
    self.indentationWidth = 20.0;
    if ([self.post respondsToSelector:@selector(depth)]) {
        self.indentationLevel = self.post.depth;
        [self createLineViews];
    }
}

- (void) createLineViews {
    self.lineViews = [NSMutableArray array];
    for (int i = 1; i <= MAX_INDENTATION_LEVEL; i++) {
        if (i >= self.indentationLevel) break;
        
        UIView *lineView = [UIView new];
        CGRect lineViewFrame = CGRectMake(0, (i * self.indentationWidth), 1 / [UIScreen mainScreen].scale, 0);
        lineView.frame = lineViewFrame;
        lineView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [self.lineViews addObject:lineView];
        [self addSubview:lineView];
    }
}

- (void) createHeaderButton {
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headerButton.backgroundColor = self.backgroundColor;
    [self.headerButton setTitle:self.headerText forState:UIControlStateNormal];
    [self.headerButton setTitleColor:[UIColor colorWithRed:0.0 green:148.0/255.0 blue:224.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.headerButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.headerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.headerButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 0);
    self.headerButton.frame = CGRectMake(0, 0, self.frame.size.width, 15.0);
    [self addSubview:self.headerButton];
}

- (NSInteger) indentationLevel {
    return MIN(_indentationLevel, MAX_INDENTATION_LEVEL);
}

- (CGFloat) width {
    return self.frame.size.width - (self.indentationLevel * self.indentationWidth);
}

- (CGFloat) x {
    return self.frame.size.width - [self width];
}

- (void) layoutSubviews {
    dispatch_async(dispatch_queue_create("Cell Loading", NULL), ^{
        CGFloat buttonHeight = self.headerButton.frame.size.height;
        
        CGRect frame = self.frame;
        frame.origin.y = buttonHeight;
        frame.origin.x = (self.indentationLevel * self.indentationWidth);
        frame.size.width -= frame.origin.x;
        
        CGRect bodyViewFrame = frame;
        bodyViewFrame.size.height = self.textViewHeight;
        
        CGRect headerFrame = frame;
        headerFrame.size.height = buttonHeight;
        headerFrame.origin.y = 0;
        
        CGRect actionFrame = self.actionsView.frame;
        actionFrame.origin.x = [self x];
        actionFrame.origin.y = self.bodyView.frame.origin.y + self.bodyView.frame.size.height - 4.0;
        actionFrame.size.height = ACTION_VIEW_HEIGHT;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerButton.frame = headerFrame;
            self.bodyView.frame = bodyViewFrame;
            
            if (!self.actionsView) {
                if ([self.post respondsToSelector:@selector(actionButtons)]) {
                    NSMutableArray *actionButtons = self.post.actionButtons;
                    [self setActionButtons:actionButtons];
                }
            }
            
            self.actionsView.frame = actionFrame;
            
            CGRect lineViewFrame = CGRectMake(0, 0, 1 / [UIScreen mainScreen].scale, frame.size.height);
            for (int i = 0; i < self.lineViews.count; i++) {
                lineViewFrame.origin.x = (i + 1) * self.indentationWidth;
                [self.lineViews[i] setFrame:lineViewFrame];
            }
        });
    });
}

- (NSString*) headerText {
    NSInteger numberPastMax = _indentationLevel - MAX_INDENTATION_LEVEL;
    if (numberPastMax > 0) {
        NSString *paddingString = @"• ";
        NSString *dots = [@"" stringByPaddingToLength:(numberPastMax * paddingString.length) withString:paddingString startingAtIndex:0];
        return [dots stringByAppendingString:self.post.headerText];
    }
    NSString *arrowString = self.collapsed ? @"▸ " : @"▾ ";
    return [arrowString stringByAppendingString:self.post.headerText];
}

- (void) tappedOnCell {
    self.actionButtonsVisible = !self.actionButtonsVisible;
    [self setNeedsLayout];
}

- (BOOL) actionButtonsVisible {
    return YES;
}

- (void) setActionButtons:(NSMutableArray *)actionButtons {
    CGRect actionFrame = CGRectZero;
    actionFrame.size = CGSizeMake([self width], ACTION_VIEW_HEIGHT);
    self.actionsView = [HHPostCellActionsView viewWithActionButtons:actionButtons
                                                              frame:actionFrame];
    [self addSubview:self.actionsView];
}

- (void) setAttributedText:(NSAttributedString*)text {
    self.bodyView.attributedText = text;
}

- (void) setText:(NSString*) text {
    self.bodyView.text = text;
}

- (void) setHeaderText:(NSString*)headerText {
    [self.headerButton setTitle:headerText forState:UIControlStateNormal];
}

- (CGSize) sizeThatFits:(CGSize)size {
    size.width = size.width - (self.indentationLevel * self.indentationWidth);
    
    if ([self.post respondsToSelector:@selector(attributedBody)]) {
        self.bodyView.attributedText = self.post.attributedBody;
    }
    else {
        self.bodyView.text = self.post.bodyText;
    }
    
    CGSize returnedSize = size;
    if (self.textViewHeight == 0) {
        returnedSize.height = [self.bodyView sizeThatFits:size].height;
        self.textViewHeight = returnedSize.height;
    }
    else {
        returnedSize.height = self.textViewHeight;
    }
    
    returnedSize.height += self.headerButton.frame.size.height;
    returnedSize.height += ACTION_VIEW_HEIGHT;
    
    return returnedSize;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"HHCollapsiblePostCell: | frame: %@ | depth: %li | text: %@...", NSStringFromCGRect(self.frame), (long)self.indentationLevel, [self.bodyView.text substringToIndex:30]];
}

@end
