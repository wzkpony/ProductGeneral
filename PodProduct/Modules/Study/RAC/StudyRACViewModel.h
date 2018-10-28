//
//  StudyRACViewModel.h
//  PodProduct
//
//  Created by wzk on 2018/3/21.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudyRACViewModel : NSObject
@property(nonatomic,strong)RACCommand *loginCommand;
@property(nonatomic,strong)RACSubject *subjectRACView;

//map的使用
-(void)mapForTest:(UIControl *)button;
@end
