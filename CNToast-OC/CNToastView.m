//
//  CNToastView.m
//  MakeupLessons
//
//  Created by 葱泥 on 16/6/17.
//  Copyright © 2016年 quanXiang. All rights reserved.
//

#import "CNToastView.h"


static float _duration = 2.0;
static NSMutableArray *_toastListMulArray = nil;
static UIFont *_textFont = nil;
static UIColor *_textColor = nil;
static UIColor *_backgroundColor = nil;
static float _corner = 0.0;
static UIOffset _offset;

@implementation CNToastView


#pragma mark -Private Method
- (instancetype)initWithAttribute:(NSAttributedString *)attribute maxWidth:(float)maxWidthFloat {
    self = [super init];
    
    if (self) {
        if (_textFont == nil) {
            [CNToastView initData];
        }
        
        self.backgroundColor = _backgroundColor;
        CGSize size = CGSizeMake(maxWidthFloat, CGFLOAT_MAX);
        CGRect rect = [attribute boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

        // 显示文本排版结果
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.frame = CGRectMake(_offset.vertical, _offset.horizontal, rect.size.width, rect.size.height);
        _titleLabel.attributedText = attribute;
        [self addSubview:_titleLabel];
        
        self.frame = CGRectMake(0, 0, rect.size.width + _offset.vertical * 2.0, rect.size.height + _offset.horizontal * 2.0);
    }
    
    return self;
}

-(void)fadeWithoutAnimation {
    [self removeFromSuperview];
    [_toastListMulArray removeObject:self];
    
    if ([_toastListMulArray count] == 0) {
        _toastListMulArray = nil;
    } else {
        [_toastListMulArray removeAllObjects];
    }
}

- (void)fadeToastOut {
    // Fade in parent view
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction
     
                     animations:^{
                         self.alpha = 0.f;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [_toastListMulArray removeObject:self];
                         
                         if ([_toastListMulArray count] == 0) {
                             _toastListMulArray = nil;
                         }
                     }];
}

+ (void)nextToastInView:(UIView *)parentView {
    if ([_toastListMulArray count] > 0) {
        CNToastView *view = [_toastListMulArray objectAtIndex:0];
        [parentView addSubview:view];
        
        [UIView animateWithDuration:.3  delay:0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             view.alpha = 1.0;
                         } completion:^(BOOL finished)
         {
             [view performSelector:@selector(fadeToastOut) withObject:nil afterDelay:_duration];
         }];
    }
}

+ (void)initData {
    _textFont = [UIFont systemFontOfSize:16.0];
    _textColor = [UIColor whiteColor];
    _backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    _corner = 4.0;
    _offset = UIOffsetMake(10.0, 20.0);
    _duration = 3.0;
}

+ (NSAttributedString *)attribute:(NSString *)string {
    if (_textFont == nil) {
        [CNToastView initData];
    }
    
    NSMutableAttributedString *mulAttribute = [[NSMutableAttributedString alloc] initWithString:string];
    mulAttribute.yy_font = _textFont;
    mulAttribute.yy_color = _textColor;
    
    return mulAttribute;
}

#pragma mark -Public Method
+ (void)offSet:(UIOffset)offset {
    _offset = offset;
}

+ (void)font:(UIFont *)stringFont {
    _textFont = stringFont;
}

+ (void)color:(UIColor *)stringColor {
    _textColor = stringColor;
}

+ (void)backgroundColor:(UIColor *)bgColor {
    _backgroundColor = bgColor;
}

+ (void)corner:(float)cornerFloat {
    _corner = cornerFloat;
}

+ (void)durationFade:(float)duration {
    _duration = duration;
}

+ (void)toastInView:(UIView *)parentView withText:(NSString *)text yPosition:(float)yFloat {
    NSAttributedString *attribute = [CNToastView attribute:text];
    [CNToastView toastInView:parentView withAttribute:attribute yPosition:yFloat];
}

+ (void)toastInView:(UIView *)parentView withText:(NSString *)text {
    [CNToastView toastInView:parentView withText:text yPosition:0.0];
}

+ (void)toastWithText:(NSString *)text {
    [CNToastView toastInView:[UIApplication sharedApplication].keyWindow withText:text];
}

+ (void)toastInView:(UIView *)parentView withAttribute:(NSAttributedString *)textAttribute {
    [CNToastView toastInView:parentView withAttribute:textAttribute yPosition:0.0];
}

+ (void)toastWithAttribute:(NSAttributedString *)textAttribute {
    [CNToastView toastInView:[UIApplication sharedApplication].keyWindow withAttribute:textAttribute];
}

+ (void)toastInView:(UIView *)parentView withAttribute:(NSAttributedString *)textAttribute yPosition:(float)yFloat {
    if ([_toastListMulArray count] > 0) {
        CNToastView *preView = [_toastListMulArray objectAtIndex:0];
        [preView fadeWithoutAnimation];
    }
    
    CNToastView *newView = [[CNToastView alloc] initWithAttribute:textAttribute maxWidth:parentView.frame.size.width];
    
    CGFloat lWidth = newView.frame.size.width;
    CGFloat lHeight = newView.frame.size.height;
    CGFloat pWidth = parentView.frame.size.width;
    CGFloat pHeight = parentView.frame.size.height;
    CGFloat viewYFloat = yFloat == 0.0 ? (pHeight - lHeight) / 2 : yFloat;
    
    // Change toastview frame
    newView.frame = CGRectMake((pWidth - lWidth - 20) / 2., viewYFloat, lWidth, lHeight);
    newView.alpha = 0.0f;
    
    if (_corner != 0.0) {
        newView.layer.cornerRadius = _corner;
        newView.layer.masksToBounds = YES;
    }
    
    if (_toastListMulArray == nil) {
        _toastListMulArray = [[NSMutableArray alloc] initWithCapacity:1];
        [_toastListMulArray addObject:newView];
    } else {
        [_toastListMulArray addObject:newView];
    }
    
    [CNToastView nextToastInView:parentView];
}

@end
