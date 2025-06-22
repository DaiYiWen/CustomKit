//
//  User.h
//  CustomKit
//
//  Created by 戴义文 on 2025/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *email;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END
