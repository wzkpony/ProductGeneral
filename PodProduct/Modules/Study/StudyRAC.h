//
//  StudyRAC.h
//  PodProduct
//
//  Created by wzk on 2018/3/16.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
@interface StudyRACModel : NSObject
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* password;
@property(nonatomic,copy)NSString* passwordConfirmation;
- (void)addObserver;
@end


@interface StudyRACView : UIView
@property(nonatomic,strong)UIButton* button;
-(void)configView;
@end


@interface StudyRACViewModel : NSObject

@end
