//
//  MySingleton.m
//  test01
//
//  Created by qa-test on 2025/5/21.
//

#import "MySingleton.h"

@implementation MySingleton

+ (instancetype)sharedInstance {
    
    static MySingleton *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}

@end
