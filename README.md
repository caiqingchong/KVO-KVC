一、KVC
/*
KVC：键值设置
注意：KVC的性能并不如直接访问属性快，虽然这个性能消耗是微乎其微的。所以在使用KVC的时候，建议最好不要手动设置属性的setter、getter，这样会导致搜索步骤变长。

而且尽量不要用KVC进行集合操作，例如NSArray、NSSet之类的，集合操作的性能消耗更大，而且还会创建不必要的对象。
使用场景：
1、runtime中修改属性参数的地方，如导航栏透明、pageControl的背景图片
*/

/*
直接提取KVOModel中的属性值，用“.”分割
因为类key反复嵌套，所以有个keyPath的概念，keyPath就是用.号来把一个一个key链接起来，这样就可以根据这个路径访问下去.
    NSLog(@"----------kvc:%@",[model valueForKeyPath: @"product.productName"]);
*/

二、KVO
/*
1.注册对象myKVO为被观察者:
option中，
NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
*/
[self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];


/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context

/*3、在dealloc中移除监听*/
- (void)dealloc{
[self removeObserver:self forKeyPath:@"num" context:nil];
}
