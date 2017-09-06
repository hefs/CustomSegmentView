//
//  CustomSegment.h
//  CustomSegmentView
//
//  Created by 何发松 on 2017/9/5.
//  Copyright © 2017年 HeRay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define MAINSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ISIPHONE6 MAINSCREENWIDTH >= 375


/**
 排列方式

 - SegmentLayoutAlignHorizontal: 水平排列
 - SegmentLayoutAlignVertical: 垂直排列
 */
typedef NS_ENUM(NSUInteger, SegmentLayoutAlign) {
    SegmentLayoutAlignHorizontal,
    SegmentLayoutAlignVertical
};
@interface CustomSegment : UIView

/**
 间隔
 */
@property (nonatomic) CGFloat space;
@property (nonatomic) SegmentLayoutAlign align;
@property (nonatomic) NSInteger selectedIndex;
/**
 按钮普通状态字体颜色
 */
@property (nonatomic, copy) UIColor *segmentNomalStateColor;

/**
 按钮选中状态字体颜色
 */
@property (nonatomic, copy) UIColor *segmentSelectedStateColor;

/**
 添加分块按钮

 @param segmentTitle 标题
 @param handler 回调
 */
- (void)addSegmentWithTitle:(NSString *)segmentTitle hanlder:(void (^)(NSString *title))handler;
//- (void)addSegmentAction:(SegmentAction *)action;
@end
