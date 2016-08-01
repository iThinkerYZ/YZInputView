//
//  ViewController.m
//  YZInputViewDemo
//
//  Created by yz on 16/8/1.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "ViewController.h"
#import "YZInputView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHCons;
@property (weak, nonatomic) IBOutlet YZInputView *inputView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 设置文本框占位文字
    _inputView.placeholder = @"请输入文字";
    
    // 监听文本框文字高度改变
    _inputView.yz_textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
        // 文本框文字高度改变会自动执行这个block，修改底部View的高度
        // 设置底部条的高度 = 文字高度 + textView距离上下间距高度（10 = 上（5）下（5）间距总和）
        _bottomHCons.constant = textHeight + 10;
    };
    
    // 设置文本框最大行数
    _inputView.maxNumberOfLines = 4;
}

// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 修改底部视图距离底部的间距
    _bottomCons.constant = _bottomCons.constant == 0?endFrame.size.height:0;
    
    // 约束动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
