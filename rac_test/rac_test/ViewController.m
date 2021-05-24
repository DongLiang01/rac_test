//
//  ViewController.m
//  rac_test
//
//  Created by 董良 on 2021/5/23.
//  Copyright © 2021 董良. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "SecondViewController.h"
#import "DLLoginViewModel.h"

@interface ViewController ()

@property (nonatomic, strong)UIButton *blackButton;
@property (nonatomic, strong)UITextField *scanTextField;
@property (nonatomic, strong)RACDisposable *disposable;
@property (nonatomic, assign)NSInteger maxNum;

@property (nonatomic, strong)DLLoginViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.orangeColor;
    _maxNum = 0;
    
    [self.view addSubview:self.blackButton];
    [self.view addSubview:self.scanTextField];
    @weakify(self)
    [[_blackButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        SecondViewController *vc = [[SecondViewController alloc] init];
        vc.title = @"登录页面";

        [[vc rac_signalForSelector:@selector(ceshiTongzhi)] subscribeNext:^(RACTuple * _Nullable x) {
            NSLog(@"第一页收到信号了");
            [self.viewModel.loginCommond execute:vc.model];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.viewModel.ceshiButton = self.blackButton;
    
    ///监听textfield
//    [[_scanTextField rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"点击了输入框");
//    }];
//    [_scanTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        if (self->_scanTextField.markedTextRange != nil) {
//            return;
//        }
//        NSLog(@"输入框改变：%@",x);
//    }];
//    [[_scanTextField rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        NSLog(@"输入完成：%@",self->_scanTextField.text);
//    }];
    
//    ///添加定时器
//    [self addTimer];
//    ///延时
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"哈哈哈哈"];
//        return nil;
//    }] delay:3] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"延时任务%@",x);
//    }];
    
//    ///kvo
//    [[_scanTextField rac_valuesForKeyPath:@"text" observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"数据发生了变化:%@",x);
//        [self->_blackButton setTitle:self->_scanTextField.text forState:UIControlStateNormal];
//    }];
    
//    ///通知
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"hahanihao" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"使用arc通知");
//    }];
    
}

-(void)addTimer{
    @weakify(self)
    self.disposable = [[RACSignal interval:3.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self)
        self.maxNum++;
        NSLog(@"定时开始:%ld",self.maxNum);
        if (self.maxNum == 10) {
            [self.disposable dispose];
        }
    }];
}

-(UIButton *)blackButton{
    if (!_blackButton) {
        _blackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _blackButton.frame = CGRectMake(50, 100, 80, 30);
        _blackButton.backgroundColor = UIColor.whiteColor;
        
        [_blackButton setTitle:@"黑色按钮" forState:UIControlStateNormal];
        [_blackButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    return _blackButton;
}

-(UITextField *)scanTextField{
    if (!_scanTextField) {
        _scanTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 180, 30)];
        _scanTextField.placeholder = @"请输入名字。。。";
        _scanTextField.backgroundColor = UIColor.whiteColor;
        _scanTextField.font = [UIFont systemFontOfSize:14];
        _scanTextField.textColor = UIColor.blueColor;
    }
    return _scanTextField;
}

-(DLLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[DLLoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
