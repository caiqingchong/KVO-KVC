//
//  KVC.m
//  KVO&KVC
//
//  Created by 张张凯 on 2018/4/3.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "KVC.h"

@implementation KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%s",__func__);
    NSLog(@"%@=%@",key,value);
}
@end
