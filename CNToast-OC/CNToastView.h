//
//  CNToastView.h
//  MakeupLessons
//
//  Created by 葱泥 on 16/6/17.
//  Copyright © 2016年 quanXiang. All rights reserved.
//
//  CNToastView 是已NSAttributedString来作为文本显示的，故可以实现多种富文本效果。
//  对外接口，提供NSString类型，如果使用NSString，则会自动根据设置的字体、颜色等参数，来自动生成NSAttributedString，并显示
//
//  注：本控件使用了YYText，感谢YYText的作者的分享
//     本控件参考ALToastView来写的，感谢ALToastView的分享精神
//
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>


@interface CNToastView : UIView {
@private
    UILabel *_titleLabel;
}

/**
 *  间距
 *
 *  @param offset UIOffset
 */
+ (void)offSet:(UIOffset)offset;

/**
 *  字体
 *
 *  @param stringFont UIFont
 */
+ (void)font:(UIFont *)stringFont;

/**
 *  字体颜色
 *
 *  @param stringColor UIColor
 */
+ (void)color:(UIColor *)stringColor;

/**
 *  背景色
 *
 *  @param bgColor UIColor
 */
+ (void)backgroundColor:(UIColor *)bgColor;

/**
 *  圆角值(注：设置为0，表示没有圆角)
 *
 *  @param cornerFloat float
 */
+ (void)corner:(float)cornerFloat;

/**
 *  停留时长
 *
 *  @param duration float
 */
+ (void)durationFade:(float)duration;

/**
 *  显示
 *
 *  @param parentView 父View
 *  @param text       NSString字符串
 *  @param yFloat     位置
 */
+ (void)toastInView:(UIView *)parentView withText:(NSString *)text yPosition:(float)yFloat;

/**
 *  显示(注：位置默认居中)
 *
 *  @param parentView 父View
 *  @param text       NSString字符串
 */
+ (void)toastInView:(UIView *)parentView withText:(NSString *)text;

/**
 *  显示(注：位置默认居中, 默认显示在window上)
 *
 *  @param text NSString字符串
 */
+ (void)toastWithText:(NSString *)text;

/**
 *  显示
 *
 *  @param parentView    父View
 *  @param textAttribute NSAttributedString 文本
 *  @param yFloat        位置
 */
+ (void)toastInView:(UIView *)parentView withAttribute:(NSAttributedString *)textAttribute yPosition:(float)yFloat;

/**
 *  显示(注：位置默认居中)
 *
 *  @param parentView    父View
 *  @param textAttribute NSAttributedString 文本
 */
+ (void)toastInView:(UIView *)parentView withAttribute:(NSAttributedString *)textAttribute;

/**
 *  显示(注：位置默认居中, 默认显示在window上)
 *
 *  @param textAttribute NSAttributedString 文本
 */
+ (void)toastWithAttribute:(NSAttributedString *)textAttribute;

@end
