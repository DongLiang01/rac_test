//
//  RACLoginVM.m
//  rac_test
//
//  Created by 董良 on 2021/6/21.
//  Copyright © 2021 董良. All rights reserved.
//

#import "RACLoginVM.h"

@implementation RACLoginVM

-(instancetype)init{
    if (self = [super init]) {
        
        [RACObserve(self, userName) subscribeNext:^(id  _Nullable x) {
            NSLog(@"用户明发生了变化%@",x);
            [self checkSubmitEnable];
        }];
        [RACObserve(self, passWord) subscribeNext:^(id  _Nullable x) {
            NSLog(@"密码生了变化%@",x);
            [self checkSubmitEnable];
        }];
        @weakify(self)
        self.validLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                BOOL status = self.userName.length > 0 && self.passWord.length > 0;
                [subscriber sendNext:@(status)];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        self.loginRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                ///放登录请求
                [subscriber sendNext:@"登录成功了"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

-(void)checkSubmitEnable{
    [self.validLoginCommand execute:nil];
}

@end
