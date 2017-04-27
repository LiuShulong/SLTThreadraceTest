# SLTThreadraceTest


A method to to test iOS thread race.You can run the demo project to see the result.

一种测试 iOS 线程竞争的方法。可以运行demo工程查看效果


核心代码如下：

```
- (void)execMultithreadWithBlock:(void(^)())block {
    for (int i = 0; i < 1000; i++) {
        @autoreleasepool {
            NSString *attr = [NSString stringWithFormat:@"%@",@([[NSDate date] timeIntervalSince1970])];
            dispatch_queue_t cusQueue = dispatch_queue_create(attr.UTF8String, DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(cusQueue, ^{
                
                if (block) {
                    block();
                }
                
            });
        }
    }

}
```
