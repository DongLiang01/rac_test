//
//  SecondViewController.m
//  rac_test
//
//  Created by 海外网 on 2021/5/24.
//  Copyright © 2021 董良. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveObjC.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 80, 30);
    button.backgroundColor = UIColor.whiteColor;
    [button setTitle:@"黑色按钮" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self ceshiTongzhi];
    }];
    
    /*
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal1-->🍺🍺🍺🍺🍺🍺🍺"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal1销毁了");
        }];
    }];
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号订阅：%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号订阅2：%@",x);
    }];
    [connection connect];
     */
}

-(void)ceshiTongzhi{
    NSLog(@"第二个页面想走代理方法");
    self.model.name = @"liangting";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hahanihao" object:nil];
    
    
    
}

-(DLLoginModel *)model{
    if (!_model) {
        _model = [[DLLoginModel alloc] init];
        _model.name = @"dongliang";
    }
    return _model;
}

@end
