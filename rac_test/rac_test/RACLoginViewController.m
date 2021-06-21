//
//  RACLoginViewController.m
//  rac_test
//
//  Created by 董良 on 2021/6/20.
//  Copyright © 2021 董良. All rights reserved.
//

#import "RACLoginViewController.h"
#import "RACLoginVM.h"

@interface RACLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)RACLoginVM *viewModel;
@property (nonatomic, strong)UITextField *userNameTextField;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *loginB;

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
//    [userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userNameTextField = userNameTextField;
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 30)];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入密码…";
    passwordTextField.secureTextEntry =  YES;
    passwordTextField.delegate = self;
//    [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(20, 250, 300, 30);
    loginButton.backgroundColor = UIColor.lightGrayColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.userInteractionEnabled = NO;
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ///在loginViewModel中进行登录操作
        NSLog(@"登录按钮");
    }];
    [self.view addSubview:loginButton];
    self.loginB = loginButton;
    
    [self bindViewModel];
}

-(void)bindViewModel{
    ///将两个信号合并：观察输入框的输入变化信号以及直接赋值text的信号
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
}

-(RACLoginVM *)viewModel{
    if (!_viewModel) {
        _viewModel = [[RACLoginVM alloc] init];
        _viewModel.validLogin = NO;
    }
    return _viewModel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
