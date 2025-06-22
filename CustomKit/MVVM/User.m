//
//  User.m
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import "User.h"

@implementation User

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age email:(NSString *)email {
    if (self = [super init]) {
        _name = [name copy];
        _age = age;
        _email = [email copy];
    }
    return self;
}

@end
