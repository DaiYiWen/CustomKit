//
//  MySingleton.h
//  test01
//
//  Created by qa-test on 2025/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySingleton : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) CGFloat totalHeight;

@end

NS_ASSUME_NONNULL_END
