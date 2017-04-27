//
//  SLTTreadraceTestTests.m
//  SLTTreadraceTestTests
//
//  Created by LiuShulong on 27/04/2017.
//  Copyright © 2017 LiuShulong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLTModel.h"

@interface SLTTreadraceTestTests : XCTestCase

@end

@implementation SLTTreadraceTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThreadRece {
    
    __block id observer;
    __block NSInteger count = 0;
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:SLTInitNoti object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        count++;
    }];
    
    [self execMultithreadWithBlock:^{
        SLTModel *model = [SLTModel sharedInstance1];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"thread race test"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        XCTAssertEqual(count, 1);
        
        
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    

}

- (void)testThreadRece2 {
    
    __block id observer;
    __block NSInteger count = 0;
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:SLTInitNoti object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        count++;
    }];
    
    [self execMultithreadWithBlock:^{
        SLTModel *model = [SLTModel sharedInstance2];
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"thread race test"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        XCTAssertEqual(count, 1);
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
    
}


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


@end
