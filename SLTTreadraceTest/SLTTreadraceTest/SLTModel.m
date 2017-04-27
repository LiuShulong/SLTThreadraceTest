//
//  SLTModel.m
//  SLTTreadraceTest
//
//  Created by LiuShulong on 27/04/2017.
//  Copyright © 2017 LiuShulong. All rights reserved.
//

#import "SLTModel.h"

NSString *const SLTInitNoti = @"SLTInitNoti";

@implementation SLTModel

+ (instancetype)sharedInstance1 {
    
    static SLTModel *model = nil;
    if (model == nil) {
        model = [[SLTModel alloc] init];
    }
    return model;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SLTInitNoti object:nil];
    }
    return self;
}

+ (instancetype)sharedInstance2 {
    
    static dispatch_once_t onceToken;
    static SLTModel *model = nil;
    dispatch_once(&onceToken, ^{
        model = [[SLTModel alloc] init];
    });
    return model;
}

@end
