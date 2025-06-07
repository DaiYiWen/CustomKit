//
//  CXCameraViewController.m
//  CXCamera
//
//  Created by c_xie on 16/3/26.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "CXCameraViewController.h"
#import "CXCameraManager.h"
#import "CXPreviewView.h"
#import "CXOverlayView.h"
#import "CXPhotoEditView.h"
#import "CXVideoEditView.h"
#import "UIView+CXExtension.h"
#import "NSTimer+CXExtension.h"
#import <CoreMotion/CoreMotion.h>
#import "UIImage+Category.h"
#import "UIImage+YYAdd.h"
#import "SceneDelegate.h"
// 隐藏缩放条时间
static const CGFloat kCXCameraHidenZoomSliderTimeInterval = 3.0f;

// 定时器获取录制时间间隔
static const CGFloat kCXCameraRecordingTimeInterval = 0.1f;

@interface CXCameraViewController ()
<
    CXCameraManagerDelegate,
    CXPreviewViewDelegate,
    CXOverLayViewDelegate
>

@property (nonatomic,weak,readwrite) id<CXCameraViewControllerDelegate> delegate;

@property (nonatomic,assign,readwrite) CXCameraMode cameraMode;

@property (nonatomic,assign,readwrite) NSTimeInterval maxRecordedDuration;

@property (nonatomic,assign,readwrite,getter=isAutomaticWriteToLibary) BOOL automaticWriteToLibary;

@property (nonatomic,assign,readwrite,getter=isAutoFocusAndExpose) BOOL autoFocusAndExpose;

@property (nonatomic,strong) CXCameraManager *cameraManager;

@property (nonatomic,weak) CXPreviewView *previewView;

@property (nonatomic,weak) CXOverlayView *overlayView;

@property (nonatomic,weak) CXPhotoEditView *photoEditView;

@property (nonatomic,weak) CXVideoEditView *videoEditView;

@property (nonatomic,strong) NSTimer *zoomSliderTimer;

@property (nonatomic,strong) NSTimer *recordingTimer;

@property (nonatomic,assign) BOOL lastAutoFocusAndExpose;

@end


@implementation CXCameraViewController

- (UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationOverFullScreen;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPreviewView];
    [self setupOverlayView];
    [self setupSession];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)onDeviceOrientationDidChange{
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.previewView.layer;
    if(Is_IPad){
        if([UIDevice currentDevice].orientation != UIDeviceOrientationFaceUp){
            layer.orientation = [self currentVideoOrientation];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopZoomSliderTimer];
    [self stopRecordingTimer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.autoFocusAndExpose) {
        [self.cameraManager resetFocusAndExposure];
//        [self.previewView autoFocusAndExposure];
    }
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - CXPreviewViewDelegate

- (void)previewView:(CXPreviewView *)preivewView singleTapAtPoint:(CGPoint)point
{
    [self.cameraManager exposeAtPoint:point];
}

- (void)previewViewWillBeginPinch:(CXPreviewView *)previewView
{
    [self stopZoomSliderTimer];
    [self.overlayView setZoomSliderHiden:NO];
}

- (void)previewViewDidEndPinch:(CXPreviewView *)previewView
{
    [self startZoomSliderTimer];
}

- (void)previewView:(CXPreviewView *)preivewView pinchScaleValueDidChange:(CGFloat)value
{
    CGFloat zoomValue = MIN([self.overlayView currentZoomValue] + value, 1.0);
    zoomValue = MAX(zoomValue, 0);
    [self.cameraManager setZoomValue:zoomValue];
}

#pragma mark - CXOverLayViewDelegate

- (void)didSelectedShutter:(CXOverlayView *)overlayView
{
    if (self.cameraMode == CXCameraModePhoto) {
        [self.cameraManager captureStillImage];
        [overlayView setShutterEnable:NO];
    } else {
        if ([self.overlayView prepareToRecording]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cameraManager startRecording];
            });
            // 录像时关闭自动对焦
            self.lastAutoFocusAndExpose = self.autoFocusAndExpose;
            if (self.autoFocusAndExpose) {
                self.cameraManager.autoFocusAndExpose = NO;
            }
        } else {
            [self.cameraManager stopRecording];
            [overlayView setShutterEnable:NO];
            if (self.lastAutoFocusAndExpose) {
                self.cameraManager.autoFocusAndExpose = self.lastAutoFocusAndExpose;
            }
        }
    }
}

- (void)didSelectedCancel:(CXOverlayView *)overlayView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        if ([self.cameraManager isRecording]) {
            [self.cameraManager stopRecording];
            [self.cameraManager stopSession];
        }
        self.previewView.delegate = nil;
        [self stopRecordingTimer];
        [self stopZoomSliderTimer];
        [self.cameraManager stopSession];
        self.cameraManager.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.previewView.layer removeFromSuperlayer];
        [self dismissCallback];
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.previewView.layer removeFromSuperlayer];
//    });
}

- (void)didSelectedFlashMode:(CXCaptureFlashMode)flashMode
{
    if ([self.cameraManager cameraHasFlash]) {
        switch (flashMode) {
            case CXCaptureFlashModeOn:
                [self.cameraManager setFlashMode:AVCaptureFlashModeOn];
                break;
            case CXCaptureFlashModeOff:
                [self.cameraManager setFlashMode:AVCaptureFlashModeOff];
                break;
            case CXCaptureFlashModeAuto:
                [self.cameraManager setFlashMode:AVCaptureFlashModeAuto];
                break;
            case CXCaptureFlashModeTorch:
                if ([self.cameraManager cameraHasTorch]) {
                    if ([self.cameraManager torchMode] == AVCaptureTorchModeOff) {
                        [self.cameraManager setTorchMode:AVCaptureTorchModeOn];
                    } else {
                        [self.cameraManager setTorchMode:AVCaptureTorchModeOff];
                    }
                }
                break;
            default:
                break;
        }
    }
}

- (void)didSwitchCamera
{
    if ([self.cameraManager switchCamera]) {
        [self.overlayView switchDeviceMode:[self.cameraManager deviceMode]];
        self.previewView.enableExpose = [self.cameraManager isCameraExposureSupported];
        if (self.cameraManager.deviceMode == CXDeviceModeFront) {
            self.previewView.enableZoom = NO;
        } else {
            self.previewView.enableZoom = YES;
        }
    }
}

- (void)didtouchDownToCameraZoomType:(CXCameraZoomType)zoomType
{
    if ([self.cameraManager isCameraZoomSupported]) {
        CGFloat zoom = 0.f;
        if (zoomType == CXCameraZoomTypePlus) {
            zoom = 1.0f;
        }
        [self.cameraManager rampZoomToValue:zoom];
    }
    [self stopZoomSliderTimer];
}

- (void)didTouchUpInsideToCameraZoomType:(CXCameraZoomType)zoomType
{
    if ([self.cameraManager isCameraZoomSupported]) {
        [self.cameraManager cancelZoom];
    }
    [self startZoomSliderTimer];
}

- (void)didTouchDownZoomSliderView:(CXOverlayView *)overlayView
{
    [self stopZoomSliderTimer];
}
- (void)didTouchUpInsideZoomSliderView:(CXOverlayView *)overlayView
{
    [self startZoomSliderTimer];
}

- (void)sliderChangeToValue:(CGFloat)zoomValue
{
    if ([self.cameraManager isCameraZoomSupported]) {
        [self.cameraManager setZoomValue:zoomValue];
    }
}

#pragma mark - CXCameraManagerDelegate

- (void)captureSessionConfigurateError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(cameraDidConfigurateError:)]) {
        [self.delegate cameraDidConfigurateError:error];
    }
}

- (void)cameraManagerConfigurateFailed:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(cameraDidConfigurateError:)]) {
        [self.delegate cameraDidConfigurateError:error];
    }
}

- (void)cameraRampZoomToValue:(CGFloat)zoomValue
{
    [self.overlayView updateZoomValue:zoomValue];
}

- (void)captureDeviceSubjectAreaDidChange
{
    if (self.autoFocusAndExpose) {
//        [self.previewView autoFocusAndExposure];
        [self.cameraManager resetFocusAndExposure];
    }
}


#pragma mark - 捕捉图片

- (void)cameraManagerDidEndCaptureStillImage:(UIImage *)image1 error:(NSError *)error
{
    UIImage *image;
    if(!Is_IPad){
        switch ([UIDevice currentDevice].orientation) {
            case UIDeviceOrientationPortraitUpsideDown:
                image = [image1 imageByRotate180];
                break;
            case UIDeviceOrientationLandscapeLeft:
                image = [image1 imageByRotateLeft90];
                break;
            case UIDeviceOrientationLandscapeRight:
                image = [image1 imageByRotateRight90];
                break;
            default:
                image = image1;
                break;
        }
    }else{
        image = image1;
    }
    
    if (!error) {
        __weak typeof(self) weakSelf = self;
        CXPhotoEditView *photoEditView = [CXPhotoEditView photoEditViewWithPhoto:image rephotographBlock:^{
            [weakSelf.photoEditView removeFromSuperview];
            [weakSelf.overlayView setShutterEnable:YES];
        } employPhotoBlock:^{
            [weakSelf.cameraManager stopSession];
            [weakSelf callBackCaptureStillImage:image error:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            [weakSelf.overlayView setShutterEnable:YES];
            [weakSelf dismissCallback];
        }];
        [self.view addSubview:photoEditView];
        self.photoEditView = photoEditView;
//        self.photoEditView.frame = self.view.bounds;
        
        
        [self.photoEditView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        [self writeToLibaryWithImage:image];
    } else {
        [self callBackCaptureStillImage:nil error:error];
    }
    
}


UIImageOrientation orientation = UIImageOrientationRight;
- (UIImage *)rotateImage:(UIImage *)image to:(UIImageOrientation)orientation {
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (orientation) {
        case UIImageOrientationUp:
            // 不需要处理
            break;
        case UIImageOrientationDown:
            CGContextTranslateCTM(context, image.size.width, image.size.height);
            CGContextRotateCTM(context, M_PI);
            break;
        case UIImageOrientationLeft:
            CGContextTranslateCTM(context, image.size.width, 0);
            CGContextRotateCTM(context, M_PI_2);
            break;
        case UIImageOrientationRight:
            CGContextTranslateCTM(context, 0, image.size.height);
            CGContextRotateCTM(context, -M_PI_2);
            break;
        case UIImageOrientationUpMirrored:
            CGContextTranslateCTM(context, image.size.width, 0);
            CGContextScaleCTM(context, -1, 1);
            break;
        case UIImageOrientationDownMirrored:
            CGContextTranslateCTM(context, 0, image.size.height);
            CGContextScaleCTM(context, 1, -1);
            break;
        case UIImageOrientationLeftMirrored:
            CGContextRotateCTM(context, M_PI_2);
            CGContextScaleCTM(context, -1, 1);
            break;
        case UIImageOrientationRightMirrored:
            CGContextRotateCTM(context, -M_PI_2);
            CGContextScaleCTM(context, -1, 1);
            break;
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)writeToLibaryWithImage:(UIImage *)image
{
    if (self.automaticWriteToLibary) {
        if ([self checkAccessForPhotosAlbum]) {
            [self.cameraManager writeImageToPhotosAlbum:image
            completionBlock:^(NSURL *assetURL, NSError *error) {
                if ([self.delegate respondsToSelector:@selector(cameraViewController:finishWriteImageToPhotosAlbum:error:)]) {
                    [self.delegate cameraViewController:self finishWriteImageToPhotosAlbum:image error:error];
                }
            }];
        }
    }
}

- (void)callBackCaptureStillImage:(UIImage *)image error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(cameraViewController:didEndCaptureImage:error:)]) {
        [self.delegate cameraViewController:self didEndCaptureImage:image error:error];
    }
}


#pragma mark - 捕捉视频

- (void)cameraManagerDidStartReocrdingVideo:(NSURL *)fileURL
{
    [self startRecordingTimer];
}

- (void)cameraManagerDidReachMaxReocrdedDuration:(NSURL *)fileURL
{
    [self cameraManagerDidEndReocrdedVideo:fileURL error:nil];
}

- (void)cameraManagerDidEndReocrdedVideo:(NSURL *)fileURL error:(NSError *)error
{
    [self stopRecordingTimer];
    [self.overlayView endRedording];
    if (!error) {
        __weak typeof(self) weakSelf = self;
        CXVideoEditView *videoEditView = [CXVideoEditView videoEditViewWithVideoURL:fileURL recordAgainBlock:^{
            [weakSelf.overlayView setShutterEnable:YES];
            [weakSelf.videoEditView removeFromSuperview];
        } employVideoBlock:^{
            [weakSelf.overlayView setShutterEnable:YES];
            [weakSelf callBackEndRecordedVideo:fileURL error:error];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            [weakSelf dismissCallback];
        }];
        [self.view addSubview:videoEditView];
        self.videoEditView = videoEditView;
//        self.videoEditView.frame = self.view.bounds;
        [self.videoEditView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.view);
        }];
        
        [self writeToLibaryWithVideoURL:fileURL];
    } else {
        [self callBackEndRecordedVideo:fileURL error:error];
    }
}

- (void)writeToLibaryWithVideoURL:(NSURL *)videoURL
{
    if (self.automaticWriteToLibary) {
        if ([self checkAccessForPhotosAlbum]) {
            [self.cameraManager writeVideoToPhotosAlbumAtPath:videoURL
              completionBlock:^(NSURL *assetURL, NSError *error) {
                  if ([self.delegate respondsToSelector:@selector(cameraViewController:finishWriteVideoToPhotosAlbumAtPath:error:)]) {
                      [self.delegate cameraViewController:self finishWriteVideoToPhotosAlbumAtPath:videoURL error:error];
                  }
              }];
        }
    }
}

- (BOOL)checkAccessForPhotosAlbum
{
    if ([self.cameraManager authorizeAssetsLibrary]) {
        return YES;
    } else {
        if ([self.delegate respondsToSelector:@selector(cameraNoAccessForPhotosAlbum)]) {
            [self.delegate cameraNoAccessForPhotosAlbum];
        }
        return NO;
    }
}

- (void)callBackEndRecordedVideo:(NSURL *)videoURL error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(cameraViewController:didEndCaptureVideo:error:)]) {
        [self.delegate cameraViewController:self didEndCaptureVideo:videoURL error:error];
    }
}


#pragma mark - private method

- (void)setupPreviewView
{
    CXPreviewView *previewView = [[CXPreviewView alloc] initWithFrame:self.view.bounds];
    previewView.delegate = self;
    [self.view addSubview:previewView];
    self.previewView = previewView;
    
    [previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupOverlayView
{
    CXOverlayView *overlayView = [[CXOverlayView alloc] initWithFrame:self.view.bounds];
    overlayView.cameraMode = self.cameraMode;
    overlayView.delegate = self;
    [self.view addSubview:overlayView];
    self.overlayView = overlayView;
    
    [overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupSession
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) { // 未授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [self configurateSession];
            }
        }];
    } else if (status == AVAuthorizationStatusAuthorized) { // 已授权
        [self configurateSession];
    } else {                                                // 拒绝或无法访问
        if ([self.delegate respondsToSelector:@selector(cameraNoAccessForMedia)]) {
            [self.delegate cameraNoAccessForMedia];
        }
    }
}

- (void)configurateSession
{
    self.cameraManager = [[CXCameraManager alloc] init];
    self.cameraManager.delegate = self;
    self.cameraManager.maxRecordedDuration = self.maxRecordedDuration;
    self.cameraManager.autoFocusAndExpose = self.autoFocusAndExpose;
    
    [self.previewView setSession:self.cameraManager.session];
    
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.previewView.layer;
    layer.orientation = [self currentVideoOrientation];
    
    [self.cameraManager startSession];
}


- (UIWindow *)getCurrentWindow{
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        NSSet *scenes = [[UIApplication sharedApplication] connectedScenes];
        SceneDelegate *windowSce = [[[scenes allObjects] firstObject] delegate];
        window = windowSce.window;
    } else {
        // Fallback on earlier versions
        window = [UIApplication sharedApplication].delegate.window;
    }
    return window;
}
- (AVCaptureVideoOrientation)currentVideoOrientation
{
    
    AVCaptureVideoOrientation orientation;
    if(!Is_IPad){
        return AVCaptureVideoOrientationPortrait;
    }
    
    UIInterfaceOrientation curInterFace;
    if(@available(iOS 13.0,*)){
        curInterFace = [self getCurrentWindow].windowScene.interfaceOrientation;
    }else{
        curInterFace = [UIApplication sharedApplication].statusBarOrientation;
    }
    switch (curInterFace) {
        case UIInterfaceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:{
            switch ([UIDevice currentDevice].orientation) {
                case UIDeviceOrientationPortrait:
                    orientation = AVCaptureVideoOrientationPortrait;
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                    orientation = AVCaptureVideoOrientationPortraitUpsideDown;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                    orientation = AVCaptureVideoOrientationLandscapeRight;
                    break;
                case UIDeviceOrientationLandscapeRight:
                    orientation = AVCaptureVideoOrientationLandscapeLeft;
                    break;
                case UIDeviceOrientationFaceUp:
                case UIDeviceOrientationFaceDown:
                default:
                    orientation = AVCaptureVideoOrientationPortrait;
                    break;
            }
        }
            break;
    }
    
//    switch ([UIDevice currentDevice].orientation) {
//        case UIDeviceOrientationPortrait:
//            orientation = AVCaptureVideoOrientationPortrait;
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            orientation = AVCaptureVideoOrientationLandscapeRight;
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            orientation = AVCaptureVideoOrientationLandscapeLeft;
//            break;
//        case UIDeviceOrientationFaceUp:
//        case UIDeviceOrientationFaceDown:
//            orientation = AVCaptureVideoOrientationPortrait;
//            break;
//        default:{
//            
//        }
//            break;
//    }
    return orientation;
}
- (void)startZoomSliderTimer
{
    [self stopZoomSliderTimer];
    __weak typeof(self) weakSelf = self;
    self.zoomSliderTimer = [NSTimer cx_scheduledTimerWithTimeInterval:kCXCameraHidenZoomSliderTimeInterval
    fireBlock:^{
        [weakSelf.overlayView setZoomSliderHiden:YES];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.zoomSliderTimer forMode:NSRunLoopCommonModes];
}

- (void)stopZoomSliderTimer
{
    [self.zoomSliderTimer invalidate];
    self.zoomSliderTimer = nil;
}

- (void)startRecordingTimer
{
    [self stopRecordingTimer];
    __weak typeof(self) weakSelf = self;
    self.recordingTimer = [NSTimer cx_timerWithTimeInterval:kCXCameraRecordingTimeInterval
                                                    repeats:YES
    fireBlock:^{
          NSString *formattedTime = [weakSelf formatRecordedTime:[weakSelf.cameraManager recordedDuration]];
          [weakSelf.overlayView setRecordingFormattedTime:formattedTime];
      }];
    [[NSRunLoop mainRunLoop] addTimer:self.recordingTimer forMode:NSRunLoopCommonModes];
    
}

- (void)stopRecordingTimer
{
    [self.recordingTimer invalidate];
    self.recordingTimer = nil;
}

- (NSString *)formatRecordedTime:(NSTimeInterval)interval
{
    NSInteger hours = interval / 3600;
    NSInteger minutes = (int)(interval / 60) % 60;
    NSInteger seconds = (int)interval % 60;
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd",hours,minutes,seconds];
}

- (void)dismissCallback
{
    if ([self.delegate respondsToSelector:@selector(cameraViewControllerDidDismiss:)]) {
        [self.delegate cameraViewControllerDidDismiss:self];
    }
}


#pragma mark - public method

/**
 *  present一个拍照相机控制器
 */
+ (instancetype)presentPhotoCameraWithDelegate:(id<CXCameraViewControllerDelegate>)delegate
                        automaticWriteToLibary:(BOOL)automaticWriteToLibary
                            autoFocusAndExpose:(BOOL)autoFocusAndExpose
{
    CXCameraViewController *cameraVC = [[CXCameraViewController alloc] init];
    cameraVC.cameraMode = CXCameraModePhoto;
    cameraVC.automaticWriteToLibary = automaticWriteToLibary;
    cameraVC.delegate = delegate;
    cameraVC.autoFocusAndExpose = autoFocusAndExpose;
    [self presentCameraVC:cameraVC];
    return cameraVC;
}

/**
 *  present一个录像相机控制器
 */
+ (instancetype)presentVideoCameraWithDelegate:(id<CXCameraViewControllerDelegate>)delegate
                           maxRecordedDuration:(NSTimeInterval)maxRecordedDuration
                        automaticWriteToLibary:(BOOL)automaticWriteToLibary
                            autoFocusAndExpose:(BOOL)autoFocusAndExpose
{
    CXCameraViewController *cameraVC = [[CXCameraViewController alloc] init];
    cameraVC.cameraMode = CXCameraModeVideo;
    cameraVC.maxRecordedDuration = maxRecordedDuration;
    cameraVC.automaticWriteToLibary = automaticWriteToLibary;
    cameraVC.delegate = delegate;
    cameraVC.autoFocusAndExpose = autoFocusAndExpose;
    [self presentCameraVC:cameraVC];
    return cameraVC;
}

+ (void)presentCameraVC:(CXCameraViewController *)cameraVC
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:cameraVC animated:YES completion:nil];
}




@end
