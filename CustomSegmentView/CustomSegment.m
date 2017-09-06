//
//  CustomSegment.m
//  CustomSegmentView
//
//  Created by 何发松 on 2017/9/5.
//  Copyright © 2017年 HeRay. All rights reserved.
//

#import "CustomSegment.h"

#define BUTTONTAGOFFSET 1000

@interface CustomSegment (){
    UIButton *currentSegment;
}

/**
 按钮回调数组
 */
@property (nonatomic) NSMutableArray *handlers;

/**
 按钮数组
 */
@property (nonatomic) NSMutableArray *buttons;
@end

@implementation CustomSegment

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSMutableArray *)handlers{
    if (!_handlers) {
        _handlers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _handlers;
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _buttons;
}


/**
 按钮点击事件

 @param sender 点击按钮
 */
- (void)didSegmentButtonClicked:(UIButton *)sender{
    if (currentSegment && currentSegment.tag == sender.tag) {
        return;
    }
    if (currentSegment) {
        currentSegment.selected = NO;
    }
    sender.selected = YES;
    
    if (sender.tag - BUTTONTAGOFFSET >= self.handlers.count) {
        return;
    }
    void (^handler)(NSString *) = [self.handlers objectAtIndex:sender.tag - BUTTONTAGOFFSET];
    handler(sender.currentTitle);
    currentSegment = sender;
}

- (void)addSegmentWithTitle:(NSString *)segmentTitle hanlder:(void (^)(NSString *))handler{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:segmentTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didSegmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = ISIPHONE6 ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:14];
    [self addSubview:button];
    [self.buttons addObject:button];
    if (handler) {
        [self.handlers addObject:handler];
    }
}


/**
 子视图布局，设置按钮位置及大小
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonWidth = _align == SegmentLayoutAlignHorizontal ? (CGRectGetWidth(self.frame) - self.buttons.count*_space)/self.buttons.count : CGRectGetWidth(self.frame);
    CGFloat buttonHeight = _align == SegmentLayoutAlignHorizontal ? CGRectGetHeight(self.frame) : (CGRectGetHeight(self.frame) - self.buttons.count*_space)/self.buttons.count;
    for (UIButton *button in self.buttons) {
        NSInteger idx = [self.buttons indexOfObject:button];
        if ((idx == _selectedIndex) || (_selectedIndex >= self.buttons.count && idx == 0)) {
            button.selected = YES;
            currentSegment = button;
        }
        CGFloat oriX = _align == SegmentLayoutAlignHorizontal ? idx*(buttonWidth + _space): 0;
        CGFloat oriY = _align == SegmentLayoutAlignHorizontal ? 0 : idx*(buttonHeight + _space);
        button.frame = CGRectMake(oriX, oriY, buttonWidth, buttonHeight);
        button.tag = BUTTONTAGOFFSET + idx;
        [button setTitleColor:_segmentNomalStateColor ? _segmentNomalStateColor : [UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:_segmentSelectedStateColor ? _segmentSelectedStateColor : [UIColor blueColor] forState:UIControlStateSelected];
        if (idx < self.buttons.count - 1) {
            CGFloat lineX = _align == SegmentLayoutAlignHorizontal ? CGRectGetMaxX(button.frame): 0;
            CGFloat lineY = _align == SegmentLayoutAlignHorizontal ? 0 : CGRectGetMaxY(button.frame);
            CGFloat lineWidth = _align == SegmentLayoutAlignHorizontal ? _space : CGRectGetWidth(button.frame)/2;
            CGFloat lineHeight = _align == SegmentLayoutAlignHorizontal ? CGRectGetHeight(button.frame)/2 : _space;
//            添加分割线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineWidth, lineHeight)];
            line.backgroundColor = [UIColor lightGrayColor];
            line.center = _align == SegmentLayoutAlignHorizontal ? CGPointMake(line.center.x, buttonHeight/2) : CGPointMake(buttonWidth/2, line.center.y);
            [self addSubview:line];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

