//
//  SecondViewController.m
//  rac_test
//
//  Created by 海外网 on 2021/5/24.
//  Copyright © 2021 董良. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveObjC.h>
#import "DLLoginViewModel.h"

@interface SecondViewController ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)DLLoginViewModel *viewModel;
@property (nonatomic, strong)RACDisposable *disposable;
@property (nonatomic, assign)NSInteger maxNum;

@end

@implementation SecondViewController

-(void)dealloc{
    NSLog(@"第二页被释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.maxNum = 0;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 80, 30);
    button.backgroundColor = UIColor.whiteColor;
    [button setTitle:@"黑色按钮" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self ceshiTongzhi];
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 100, 50)];
    titleLabel.backgroundColor = UIColor.whiteColor;
    titleLabel.textColor = UIColor.blackColor;
    titleLabel.text =  @"初始";
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
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
    
//    RACSubject * subject = [RACSubject subject];
//
//        [subject subscribeNext:^(id  _Nullable x) {
//            NSLog(@"1.接收到了%@",x);
//        }];
//        [subject subscribeNext:^(id  _Nullable x) {
//            NSLog(@"2.接收到了%@",x);
//        }];
//    [subject sendNext:@"hello word"];
//    [subject sendNext:@"hello word222"];
//        [subject sendCompleted];
//
//        RACReplaySubject * replaySub = [RACReplaySubject subject];
//
//        [replaySub subscribeNext:^(id  _Nullable x) {
//            NSLog(@"1.接收到了%@",x);
//        }];
//        [replaySub subscribeNext:^(id  _Nullable x) {
//            NSLog(@"2.接收到了%@",x);
//        }];
//    [replaySub sendNext:@"hello"];
//    [replaySub sendNext:@"kitty"];
}

-(void)ceshiTongzhi{
//    NSLog(@"第二个页面想走代理方法");
//    self.model.name = @"liangting";
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hahanihao" object:nil];
    
    ///请求数据
    [self.viewModel.loginCommond2 execute:nil];
    ///数据显示
    self.viewModel.siginal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            [subscriber sendNext:@(self.maxNum)];
            self.maxNum++;
            if (self.maxNum == 5) {
                [self.disposable dispose];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
    self.viewModel.titleLabel = _titleLabel;
}

-(DLLoginModel *)model{
    if (!_model) {
        _model = [[DLLoginModel alloc] init];
        _model.name = @"dongliang";
    }
    return _model;
}

-(DLLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[DLLoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
