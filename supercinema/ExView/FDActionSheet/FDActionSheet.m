//
//  FDActionSheet.m
//  FDActionSheetDemp
//
//  Created by fergusding on 15/5/28.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDActionSheet.h"


#define MARGIN_LEFT 20
#define MARGIN_RIGHT 20
#define SPACE_SMALL 5
#define TITLE_FONT_SIZE 15
#define BUTTON_FONT_SIZE 14

@interface FDActionSheet ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation FDActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSMutableArray *)otherButtonTitles{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
        for (int i=0; i<otherButtonTitles.count; i++) {
            NSDictionary *obj = otherButtonTitles[i];
            [_buttonTitleArray addObject:[obj objectForKey:@"name"]];
        }
//        va_list args;
//        va_start(args, otherButtonTitles);
//        if (otherButtonTitles) {
//            [_buttonTitleArray addObject:otherButtonTitles];
//            while (1) {
//                NSString *otherButtonTitle = va_arg(args, NSString *);
//                if (otherButtonTitle == nil) {
//                    break;
//                } else {
//                    [_buttonTitleArray addObject:otherButtonTitle];
//                }
//            }
//        }
//        va_end(args);
        
        
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha = 0;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];
        
        [self initContentView];
    }
    return self;
}

- (void)initContentView
{
    contentViewWidth = self.frame.size.width;
    contentViewHeight = 0;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    
    _buttonView = [[UIView alloc] init];
    _buttonView.backgroundColor = [UIColor whiteColor];
    
    [self initTitle];
    [self initButtons];
    [self initCancelButton];
    
    _contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth ) / 2, self.frame.size.height, contentViewWidth, contentViewHeight);
    _contentView.backgroundColor = RGBA(229, 229, 229,1);
    [self addSubview:_contentView];
}

- (void)initTitle {
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, 50)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = MKFONT(TITLE_FONT_SIZE) ;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonView addSubview:_titleLabel];
        contentViewHeight += _titleLabel.frame.size.height;
    }
}

- (void)initButtons {
    if (_buttonTitleArray.count > 0) {
        NSInteger count = _buttonTitleArray.count;
        for (int i = 0; i < count; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, 0.8)];
            lineView.backgroundColor = RGBA(0, 0, 0, 0.05);
            [_buttonView addSubview:lineView];
            UIButton *button = [[UIButton alloc] init];
            if (i == 0) {
                button.frame = CGRectMake(0, contentViewHeight , contentViewWidth, 45);
            }else{
                button.frame = CGRectMake(0, contentViewHeight+0.8 , contentViewWidth, 44);
            }
            //button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = MKFONT(16);
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:RGBA(26, 29, 36,0.8) forState:UIControlStateNormal];
            [button setTitleColor:RGBA(255, 255, 255,0.8) forState:UIControlStateHighlighted];
            [button setBackgroundImage:[ImageOperation imageWithColor:RGBA(255, 255, 255,1)  size:CGSizeMake(contentViewWidth, 46)] forState:UIControlStateNormal];
            [button setBackgroundImage:[ImageOperation imageWithColor:RGBA(178, 178, 178,1)  size:CGSizeMake(contentViewWidth, 46)] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_buttonView addSubview:button];
            contentViewHeight += lineView.frame.size.height + 44;
        }
        _buttonView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
        //_buttonView.layer.cornerRadius = 5.0;
        //_buttonView.layer.masksToBounds = YES;
        [_contentView addSubview:_buttonView];
    }
}

- (void)initCancelButton {
    if (_cancelButtonTitle != nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + SPACE_SMALL, contentViewWidth, 44)];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = MKFONT(15);
        //_cancelButton.layer.cornerRadius = 5.0;
        [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        //[_cancelButton setTitleColor:[UIColor colorWithRed:0 / 255.0 green:122 / 255.0 blue:255 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:RGBA(51, 51, 51,1) forState:UIControlStateNormal];
        [_cancelButton setTitleColor:RGBA(255, 255, 255,0.8) forState:UIControlStateHighlighted];
        [_cancelButton setBackgroundImage:[ImageOperation imageWithColor:RGBA(255, 255, 255,1)  size:CGSizeMake(contentViewWidth, 44)] forState:UIControlStateNormal];
        [_cancelButton setBackgroundImage:[ImageOperation imageWithColor:RGBA(178, 178, 178,1)  size:CGSizeMake(contentViewWidth, 44)] forState:UIControlStateHighlighted];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        contentViewHeight += SPACE_SMALL + _cancelButton.frame.size.height;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = cancelButtonTitle;
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

- (void)hide {
    [self removeAnimation];
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    
    if (size > 0) {
        _titleLabel.font = MKFONT(size);
    }
}

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(int)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (bgcolor != nil) {
        [button setBackgroundColor:bgcolor];
    }
    
    if (size > 0) {
        button.titleLabel.font = MKFONT(size);
    }
}

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size {
    if (color != nil) {
        [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (bgcolor != nil) {
        [_cancelButton setBackgroundColor:bgcolor];
    }
    
    if (size > 0) {
        _cancelButton.titleLabel.font = MKFONT(size);
    }
}

- (void)addAnimation {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0.7;
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.3 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)buttonPressed:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonIndex:)]) {
        for (int i = 0; i < _buttonArray.count; i++) {
            if (button == _buttonArray[i]) {
                [_delegate actionSheet:self clickedButtonIndex:i];
                break;
            }
        }
    }
    [self hide];
}

- (void)cancelButtonPressed:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [_delegate actionSheetCancel:self];
    }
    [self hide];
}

@end
