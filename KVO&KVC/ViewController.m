//
//  ViewController.m
//  KVO&KVC
//
//  Created by 张张凯 on 2018/4/3.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "ViewController.h"
#import "KVO.h"
#import "KVC.h"
@interface ViewController (){
    UILabel *lab;
    
}
@property (nonatomic,retain) KVO *myKVO;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self makeUI];
    
    /*
     KVC：键值设置
     注意：KVC的性能并不如直接访问属性快，虽然这个性能消耗是微乎其微的。所以在使用KVC的时候，建议最好不要手动设置属性的setter、getter，这样会导致搜索步骤变长。
     
     而且尽量不要用KVC进行集合操作，例如NSArray、NSSet之类的，集合操作的性能消耗更大，而且还会创建不必要的对象。
     使用场景：
     1、runtime中修改属性参数的地方，如导航栏透明、pageControl的背景图片
     */
    KVC *model = [[KVC alloc]init];
  
    
    
    
    self.myKVO = [[KVO alloc]init];//大哥，别忘了初始化啊，这么低级的错误。
    /*
     1、未使用KVC的赋值
     myKVC.name = @"zhangsan";
     self.myKVO.productName = @"productName";
     myKVC.KVOModel = self.myKVO;
     self.myKVO.productName = @"productName";
     
     NSLog(@"---------------kvo:%@",self.myKVO.productName);
     */
    //2、使用KVC的赋值
    [model setValue:@"wangwu" forKey:@"name"];
 
    model.product = self.myKVO;
    NSLog(@"----------KVC:%@",[model valueForKeyPath:@"name"]);
    
  
    /*
     直接提取KVOModel中的属性值，用“.”分割
     因为类key反复嵌套，所以有个keyPath的概念，keyPath就是用.号来把一个一个key链接起来，这样就可以根据这个路径访问下去.
     */
    [model setValue:@"NIKE" forKeyPath:@"product.productName"];

    NSLog(@"----------kvc:%@",[model valueForKeyPath: @"product.productName"]);
    
    
    
    /*
     1.注册对象myKVO为被观察者:
     option中，
     NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
     NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
     */
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"num"] && object == self.myKVO) {
        //判断是否为muKVO的监控的值，然后改变参数
        lab.text = [NSString stringWithFormat:@"KVO监控的值为：%@",[change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}


- (void)numChange{
    
    self.myKVO.num = self.myKVO.num + 1;

}
/*3、在dealloc中移除监听*/
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"num" context:nil];
}

- (void)makeUI{
    lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 100)];
    lab.backgroundColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lab];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(100, 300, 100, 100);
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"KVO监控" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(numChange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
