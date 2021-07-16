//
//  main.m
//  rac_test
//
//  Created by 董良 on 2021/5/23.
//  Copyright © 2021 董良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

///一个旋转数组[5,6,1,2,3,4],输出它最小的的值
int minNumber(NSArray *array){
    int min = 0;
    int max = (int)array.count - 1;
    while (max-min > 1) {
        int mid = (min+max)/2;
        if ([array[min] intValue] <= [array[mid] intValue]) {
            min = mid;
        }else if([array[mid] intValue] <= [array[max] intValue]){
            max = mid;
        }
    }
    return [array[max] intValue];
}

///n*m的二维数组，每行每列都是递增的，判断一个值是不是在这个数组中
bool haveNumber(NSArray *array,int a){
    bool have = NO;
    
    int m = (int)[array[0] count];
    int n = (int)array.count;
    int index = m-1;
    int line = 0;
    while (index >= 0 && line <= n-1) {
        NSArray *array1 = array[line];
        int obj = [array1[index] intValue];
        if (a > obj) {
            line += 1;
        }else if(a < obj){
            index -= 1;
        }else{
            have = YES;
            break;
        }
    }
    
    return have;
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        NSLog(@"最小的值是%d",minNumber(@[@6,@8,@9,@18,@4]));
        if (haveNumber(@[@[@1,@4,@8,@15],@[@2,@5,@9,@19],@[@3,@6,@10,@21]], 3)) {
            NSLog(@"有这个值");
        }else{
            NSLog(@"没这个值");
        }
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

