//
//  RACLoginViewController.m
//  rac_test
//
//  Created by 董良 on 2021/6/20.
//  Copyright © 2021 董良. All rights reserved.
//

#import "RACLoginViewController.h"
#import "RACLoginVM.h"
//#import "RACLoginVM+ceshi.h"

@interface RACLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)RACLoginVM *viewModel;
@property (nonatomic, strong)UITextField *userNameTextField;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *loginB;

@property (nonatomic, assign)int number;

@end

@implementation RACLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.greenColor;
    //创建界面元素
    UITextField *userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 30)];
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.placeholder = @"请输入用户名…";
    [userNameTextField becomeFirstResponder];
    userNameTextField.delegate = self;
    [self.view addSubview:userNameTextField];
    self.userNameTextField = userNameTextField;
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 30)];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入密码…";
    passwordTextField.secureTextEntry =  YES;
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(20, 250, 300, 30);
    loginButton.backgroundColor = UIColor.lightGrayColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.userInteractionEnabled = NO;
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ///在loginViewModel中进行登录操作
        [self.viewModel.loginRequestCommand execute:nil];
    }];
    [self.view addSubview:loginButton];
    self.loginB = loginButton;
    
    [self bindViewModel];
    
    NSLog(@"当前时间%@",[self getCurrentTimes]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification1" object:nil];
    
    
    NSLog(@"并不是私有属性：%@",_viewModel.phone);
}

-(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}

-(void)bindViewModel{
    ///将两个信号合并：观察输入框的输入变化信号以及直接赋值text的信号，绑定
    RAC(self.viewModel,userName) = [RACSignal merge:@[RACObserve(self.userNameTextField, text),self.userNameTextField.rac_textSignal]];
    RAC(self.viewModel,passWord) = [RACSignal merge:@[RACObserve(self.passwordTextField, text),self.passwordTextField.rac_textSignal]];
    
    ///订阅viewModel的按钮状态信号
    [[self.viewModel.validLoginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        BOOL status = [x boolValue];
        if (status) {
            self.loginB.userInteractionEnabled = YES;
            self.loginB.backgroundColor = UIColor.redColor;
        }else{
            self.loginB.userInteractionEnabled = NO;
            self.loginB.backgroundColor = UIColor.lightGrayColor;
        }
    }];
    [[self.viewModel.loginRequestCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(RACLoginVM *)viewModel{
    if (!_viewModel) {
        _viewModel = [[RACLoginVM alloc] init];
        _viewModel.validLogin = NO;
        _viewModel.phone = @"123333";
    }
    return _viewModel;
}

@end
