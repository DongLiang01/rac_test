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

- (void)loginSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    if (self.userName.length <= 0) {
        NSLog(@"请输入用户名");
    }
    if (self.passWord.length <= 0) {
        NSLog(@"请输入密码");
    }
    success(@"登录成功");
}

-(void)setLoginButtonValid{
    if (_userName.length > 0 && _passWord.length > 0) {
        self.validLogin = YES;
    }else{
        self.validLogin = NO;
    }
}

-(void)setUserName:(NSString *)userName{
    _userName = userName;
    [self setLoginButtonValid];
}

-(void)setPassWord:(NSString *)passWord{
    _passWord = passWord;
    [self setLoginButtonValid];
}

@end
