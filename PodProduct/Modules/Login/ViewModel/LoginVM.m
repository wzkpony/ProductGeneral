//
//  LoginVM.m
//  PodProduct
//
//  Created by wzk on 2018/3/9.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "LoginVM.h"

static NSString *const kSubscribeURL = @"http://reactivetest.apiary.io/subscribers";
@interface LoginVM ()
@property(nonatomic, strong) RACSignal *emailValidSignal;

@end

@implementation LoginVM


- (id)init {
    self = [super init];
    if (self) {
        [self mapSubscribeCommandStateToStatusMessage];
    }
    return self;
}

- (void)mapSubscribeCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.subscribeCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
        return NSLocalizedString(@"Sending request...", nil);
    }];
    
   RACSignal *completedMessageSource =  [self.subscribeCommand.executionSignals flattenMap:^__kindof RACSignal * _Nullable(RACSignal *subscribeSignal) {
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeCompleted;
            
        }] map:^id(id value) {
            
            return NSLocalizedString(@"Thanks", nil);
            
        }];
    }];
    
    
    
    RACSignal *failedMessageSource = [[self.subscribeCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        return NSLocalizedString(@"Error :(", nil);
    }];
    
    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}




@end
