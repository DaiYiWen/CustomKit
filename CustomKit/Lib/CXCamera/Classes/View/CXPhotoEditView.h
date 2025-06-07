//
//  CXPhotoEditView.h
//  CXCamera
//
//  Created by c_xie on 16/4/4.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CXCameraRephotographBlock)(void); // 重拍
typedef void(^CXCameraEmployPhotoBlock)(void);  // 使用图片

@interface CXPhotoEditView : UIView

+ (instancetype)photoEditViewWithPhoto:(UIImage *)photo
                     rephotographBlock:(CXCameraRephotographBlock)rephotographBlock
                      employPhotoBlock:(CXCameraEmployPhotoBlock)employPhotoBlock;

@end
