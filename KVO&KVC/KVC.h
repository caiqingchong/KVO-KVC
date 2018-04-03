//
//  KVC.h
//  KVO&KVC
//
//  Created by 张张凯 on 2018/4/3.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVO.h"
@interface KVC : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,retain) KVO *product;
@end
