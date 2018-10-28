//
//  LoginVM.h
//  PodProduct
//
//  Created by wzk on 2018/3/9.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LoginVM : NSObject
@property(nonatomic, strong) RACCommand *subscribeCommand;

// write to this property
@property(nonatomic, strong) NSString *email;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@end
