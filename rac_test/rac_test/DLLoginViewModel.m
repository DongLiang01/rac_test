//
//  DLLoginViewModel.m
//  rac_test
//
//  Created by 海外网 on 2021/5/24.
//  Copyright © 2021 董良. All rights reserved.
//

#import "DLLoginViewModel.h"

@implementation DLLoginViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    @weakify(self)
    self.loginCommond = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        self.model = input;
        [self.ceshiButton setTitle:self.model.name forState:UIControlStateNormal];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            return nil;
        }];
    }];
}

@end
