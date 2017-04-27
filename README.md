# SLTThreadraceTest

一种测试线程竞争的方法。

核心代码如下：
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
