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
    
    self.loginCommond2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        ///第二个页面进行数据处理
        self.dataArray = @[@"你好",@"狗狗币",@"要",@"涨到",@"1美元"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            return nil;
        }];
    }];
    
}

-(void)setTitleLabel:(UILabel *)titleLabel{
    _titleLabel = titleLabel;
    @weakify(self)
    [self.siginal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSInteger idx = [x integerValue];
        self.titleLabel.text = self.dataArray[idx];
    }];
}

@end
