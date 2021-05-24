//
//  DLLoginViewModel.h
//  rac_test
//
//  Created by 海外网 on 2021/5/24.
//  Copyright © 2021 董良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLoginModel.h"
#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLLoginViewModel : NSObject

@property (nonatomic, strong)DLLoginModel *model;
@property (nonatomic, strong)UIButton *ceshiButton;
@property(nonatomic,strong)RACCommand * loginCommond;

@end

NS_ASSUME_NONNULL_END
