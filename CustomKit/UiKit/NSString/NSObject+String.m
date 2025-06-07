//
//  NSObject+String.m
//  Ugram
//
//  Created by zjh on 2022/7/7.
//

#import "NSObject+String.h"

@implementation NSObject (String)

- (NSString *)toString{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }else if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self stringValue];
    }else {
        return [NSNumber numberWithInteger:(NSInteger)self].stringValue;
    }
}

@end
