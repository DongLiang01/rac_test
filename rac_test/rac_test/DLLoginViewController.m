//
//  DLLoginViewController.m
//  rac_test
//
//  Created by 董良 on 2021/6/20.
//  Copyright © 2021 董良. All rights reserved.
//

#import "DLLoginViewController.h"
#import <ReactiveObjC.h>
#import "DLLoginViewModel.h"

@interface DLLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)DLLoginViewModel *loginViewModel;
@property (nonatomic, strong)UITextField *userNameTextField;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *loginB;

@end

@implementation DLLoginViewController

-(void)dealloc{
    [self.loginViewModel removeObserver:self forKeyPath:@"validLogin"];
    NSLog(@"test11");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    //创建界面元素
    UITextField *userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 300, 30)];
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.placeholder = @"请输入用户名…";
    [userNameTextField becomeFirstResponder];
    userNameTextField.delegate = self;
    [self.view addSubview:userNameTextField];
    [userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userNameTextField = userNameTextField;
    
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 300, 30)];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入密码…";
    passwordTextField.secureTextEntry =  YES;
    passwordTextField.delegate = self;
    [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(20, 250, 300, 30);
    loginButton.backgroundColor = UIColor.lightGrayColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.userInteractionEnabled = NO;
    [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ///在loginViewModel中进行登录操作
        [self.loginViewModel loginSuccess:^(id  _Nonnull json) {
            NSLog(@"%@",json);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"登录失败");
        }];
    }];
    [self.view addSubview:loginButton];
    self.loginB = loginButton;
        
    ///观察者观察viewModel的按钮状态属性
    [self.loginViewModel addObserver:self forKeyPath:@"validLogin" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"validLogin"]) {
        ///观察者观察按钮状态的属性
        BOOL canClick = [change[@"new"] boolValue];
        if (canClick) {
            self.loginB.userInteractionEnabled = YES;
            self.loginB.backgroundColor = UIColor.redColor;
        }else{
            self.loginB.userInteractionEnabled = NO;
            self.loginB.backgroundColor = UIColor.lightGrayColor;
        }
    }
}

///数据bind
-(void)textFieldDidChange:(UITextField *)textField
{
    if ([textField isEqual:self.userNameTextField]) {
        _loginViewModel.userName = self.userNameTextField.text;
    }else if([textField isEqual:self.passwordTextField]){
        _loginViewModel.passWord = self.passwordTextField.text;
    }
}

-(DLLoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[DLLoginViewModel alloc] init];
        _loginViewModel.validLogin = NO;
    }
    return _loginViewModel;
}


@end
