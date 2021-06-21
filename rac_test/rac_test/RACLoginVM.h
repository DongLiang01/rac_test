//
//  RACLoginVM.h
//  rac_test
//
//  Created by 董良 on 2021/6/21.
//  Copyright © 2021 董良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface RACLoginVM : NSObject

@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *passWord;
@property (nonatomic, assign)BOOL validLogin;

/// 按钮能否点击
@property (nonatomic, strong) RACCommand *validLoginCommand;
///登录请求
@property (nonatomic, strong) RACCommand *loginRequestCommand;

@end

NS_ASSUME_NONNULL_END
