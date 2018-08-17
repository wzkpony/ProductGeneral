//
//  StudyRACView.h
//  PodProduct
//
//  Created by wzk on 2018/3/21.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "StudyRACViewModel.h"

@interface StudyRACView : UIView
@property(nonatomic,strong)UIButton *button;


@property(nonatomic,strong)UITextField *textField;




@property(nonatomic,strong)UIButton *loginButton;

/**
 每个控制器都有一个ViewModel  用来请求网络，tableview的数据源处理以及cellViewModel的组装
 */
@property (nonatomic,strong,readonly) StudyRACViewModel *viewModel;

-(void)configView;
@end
