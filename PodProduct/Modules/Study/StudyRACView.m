//
//  StudyRACView.m
//  PodProduct
//
//  Created by wzk on 2018/3/21.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "StudyRACView.h"


@interface StudyRACView()
{
}

@end
@implementation StudyRACView

-(void)configView
{
    _viewModel = [[StudyRACViewModel alloc] init];
    
    self.backgroundColor = [UIColor redColor];
    self.button = [[UIButton alloc] init];
    self.loginButton = [[UIButton alloc] init];
    [self addSubview:self.button];
    [self addSubview:self.loginButton];
    __weak StudyRACView *mySelf = self;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mySelf).offset(20);
        make.left.equalTo(mySelf).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 100));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button).offset(10);
        make.left.equalTo(mySelf).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    self.button.backgroundColor = [UIColor blueColor];
    self.loginButton.backgroundColor = [UIColor yellowColor];
    [self subscribeSignalButton];//订阅button的点击事件
    [self commandRAC];//button的操作时间监听
    
    /*
     为viewModel.subjectRACView订阅一个信号，回调使用，也就是刷新UI
     */
    [[_viewModel.subjectRACView map:^id _Nullable(id  _Nullable value) {
        return value;
    }]subscribeNext:^(id  _Nullable x) {
        [mySelf viewClick:x];
    }];
    
    //监听viewClick方法的调用，如果调用了，则会走block
    [[self rac_signalForSelector:@selector(viewClick:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"viewClick调用了x:%@",x);
    }];
    
    
}
-(void)viewClick:(id)obj
{
    if ([obj isEqualToString:@"signalYES"]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.backgroundColor = [UIColor grayColor];
    }
    
}

#pragma  mark -- 订阅button的点击事件 --
-(void)subscribeSignalButton
{
    //button点击事件
    //    __weak StudyRACView *mySelf = (StudyRACView *)self;
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [_viewModel mapForTest:x];
        
    }];
}

-(void)commandRAC
{
    //这是view层，所以紧紧是和ViewModel绑定操作。绑定后，当button有事件操作时，就会触发_viewModel.loginCommand的信号。
    self.loginButton.rac_command = _viewModel.loginCommand;
}

@end

