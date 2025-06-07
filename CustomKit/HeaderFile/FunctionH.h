//
//  FunctionH.h
//  jiujiuapp
//
//  Created by apple on 2021/2/23.
//

#ifndef FunctionH_h
#define FunctionH_h

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

//#define PT Screen_Width/375

//#define NavigationHeight ([DyTools isXSeries]?88:64) //88:64
#define NavigationHeight ([DyTools isXSeries]?88:64) //88:64
#define TabarHeight ([DyTools isXSeries]?83:49)
#define StatusBarHeight \
({CGFloat statusBarHeight = 0.0;\
if (@available(iOS 13.0, *)) {\
statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else { \
statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;\
}\
(statusBarHeight);\
})

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(Screen_Width, Screen_Height))
#define SCREEN_MIN_LENGTH (MIN(Screen_Width, Screen_Height))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define WG_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define WG_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define WG_SafeAreaBottomHeight ((WG_SCREEN_HEIGHT == 812.0 || WG_SCREEN_HEIGHT == 896.0 )? 34 : 0)

#define WG_SafeAreaTopHeight ((WG_SCREEN_HEIGHT == 812.0 || WG_SCREEN_HEIGHT == 896.0 )? 88 : 64)
#define WEAKSELF __weak typeof(self)  weakSelf = self;

//判断是否是ipad
//#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6 6s 7系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6p 6sp 7p系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)
//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)


#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define TagValue  1000
#define AlertTime 0.2 //弹出动画时间

// block 宏
#define weakSelf(self) __weak typeof(self) weakSelf = self;
#define strongSelf(self)__strong typeof(weakSelf) strongSelf = self;

//判断是是否是Pad
#define Is_IPad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

//判断对象不为空
#define NotEmpty_String(obj) (obj&&((NSNull *)obj!=[NSNull null]) && [obj isKindOfClass:[NSString class]] && [obj length] > 0)

#define FeedbackGenerator()\
({\
})\

//UIImpactFeedbackGenerator *impactFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];\
//[impactFeedBack prepare];\
//[impactFeedBack impactOccurred];\

#define RefreshControl()\
({\
UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];\
refreshControl.tintColor = [UIColor D_ColorStr:@"#E0C57B"];\
NSMutableDictionary *attributes = [NSMutableDictionary dictionary];\
attributes[NSForegroundColorAttributeName] = [UIColor D_ColorStr:@"#E0C57B"];\
refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新" attributes:attributes];\
(refreshControl);\
})\

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] : " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...);
#endif



#ifdef DEBUG
#define SDLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SDLog(...)
#endif

// 打印
#ifdef DEBUG
#   define SLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#   define SL_Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define SL_NSLog(...) printf("%f %s %ld :%s\n",[[NSDate date]timeIntervalSince1970],strrchr(__FILE__,'/'),[[NSNumber numberWithInt:__LINE__] integerValue],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#   define SLog(fmt, ...)
#   define SL_Log(...)
#   define SL_NSLog(...)
#endif

//阴影
#define SetShadow(View,Opacity)\
({\
View.layer.shadowOffset = CGSizeMake(0, 5);\
View.layer.shadowColor = [UIColor blackColor].CGColor;\
View.layer.shadowOpacity = Opacity;\
View.layer.shadowRadius = 5;\
View.layer.masksToBounds = NO;\
})\

//图片手势
#define ViewGestures(view,function)\
({\
view.userInteractionEnabled=YES;\
UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(function:)];\
[tapGesture setNumberOfTapsRequired:1];\
[view addGestureRecognizer:tapGesture];\
})\

//获取缓存数据
#define GetCacheData(fileName,model,arry)\
({\
NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];\
NSString * url = [docDir stringByAppendingPathComponent:fileName];\
NSArray * models = [NSArray arrayWithContentsOfFile:url];\
for (int i=0; i<models.count; i++) {\
NSDictionary *dict=models[i];\
model *cellModel=[model mj_objectWithKeyValues:dict];\
[arry addObject:cellModel];\
}\
})\
//设置缓存
#define SetCacheData(fileName,model,arry)\
({\
NSMutableArray *arrayl=[NSMutableArray array];\
for (int i=0; i<arry.count; i++) {\
model *cellModel=arry[i];\
NSDictionary *dict=cellModel.mj_keyValues;\
[arrayl addObject:dict];\
}\
NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];\
NSString * url = [docDir stringByAppendingPathComponent:fileName];\
if ([arrayl writeToFile:url atomically:YES]) {\
DLog(@"缓存数据设置成功=====%@",fileName);\
}else{\
DLog(@"缓存数据设置失败=====%@",fileName);\
}\
})\

//提示
#define showMessage(Message)\
({\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.detailsLabel.text = Message;\
hud.userInteractionEnabled = YES;\
hud.removeFromSuperViewOnHide = YES;\
hud.detailsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];\
[hud hideAnimated:YES afterDelay:2.0];\
hud.bezelView.style=MBProgressHUDBackgroundStyleSolidColor;\
hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];\
hud.contentColor = [UIColor whiteColor];\
hud.detailsLabel.textColor=[UIColor whiteColor];\
hud.offset = CGPointMake(0.f, -(Screen_Height/2-NavigationHeight));\
})\

//提示
#define showMessageB(Message)\
({\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.detailsLabel.text = Message;\
hud.userInteractionEnabled = YES;\
hud.removeFromSuperViewOnHide = YES;\
hud.detailsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];\
[hud hideAnimated:YES afterDelay:1.0];\
hud.bezelView.style=MBProgressHUDBackgroundStyleSolidColor;\
hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];\
hud.contentColor = [UIColor whiteColor];\
hud.detailsLabel.textColor=[UIColor whiteColor];\
hud.offset = CGPointMake(0.f, -(Screen_Height/2-NavigationHeight));\
})\

//提示
#define showMessageC(Message)\
({\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.detailsLabel.text = Message;\
hud.userInteractionEnabled = YES;\
hud.removeFromSuperViewOnHide = YES;\
hud.detailsLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];\
[hud hideAnimated:YES afterDelay:1.0];\
hud.bezelView.style=MBProgressHUDBackgroundStyleSolidColor;\
hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];\
hud.contentColor = [UIColor whiteColor];\
hud.detailsLabel.textColor=[UIColor whiteColor];\
})\

//
//hud.bezelView.style=MBProgressHUDBackgroundStyleSolidColor;\
//hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];\
//hud.contentColor = [UIColor whiteColor];\
//hud.detailsLabel.textColor=[UIColor whiteColor];\


//提示
#define showMessageDone(Message)\
({\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];\
hud.mode = MBProgressHUDModeCustomView;\
UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];\
hud.customView = [[UIImageView alloc] initWithImage:image];\
hud.square = YES;\
hud.label.text = NSLocalizedString(Message, @"HUD done title");\
hud.bezelView.backgroundColor=[UIColor blackColor];\
hud.label.textColor=[UIColor whiteColor];\
[hud hideAnimated:YES afterDelay:2.f];\
})\

//导航栏颜色
#define NavigationHeightView(Color)\
({\
UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, NavigationHeight)];\
view.backgroundColor=[UIColor D_ColorStr:Color];\
view.layer.zPosition=5;\
[self.view addSubview:view];\
})\


#define BrokenNetworkPrompt(teger)\
({\
UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, NavigationHeight, Screen_Width, Screen_Height-NavigationHeight)];\
view.backgroundColor=[UIColor D_ColorStr:LineViewColor];\
[self.view addSubview:view];\
UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2-60, 120, 120, 75)];\
imageview.image=GetImage(@"bear_fail");\
imageview.layer.zPosition=5;\
[view addSubview:imageview];\
NSString*str=@"网络不给力，请检查下网络设置或稍后重试";\
NSString*strB=@"当前没有网络！>_<";\
if (teger==1) {\
    str=@"请求失败，请检查下网络设置或稍后重试";\
    strB=@"请求失败！>_<";\
}\
UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-(Screen_Width/4),205, Screen_Width/2, 40)];\
label.text = str;\
label.textColor=[UIColor D_ColorStr:@"#666666"];\
label.font=[UIFont fontWithName:@"Arial" size:14];\
label.textAlignment = NSTextAlignmentCenter;\
label.numberOfLines=0;\
[view addSubview:label];\
showMessage(strB);\
})\

//提示框
#define HUDinit(HUD,view,str)\
({\
HUD = [[MBProgressHUD alloc] initWithView:view];\
[view addSubview:HUD];\
HUD.detailsLabel.text = str;\
[HUD showAnimated:YES];\
})\

#define HUDremove(HUD)\
({\
HUD.hidden=YES;\
[HUD removeFromSuperview];\
})\

//弹出view
#define PopupView(view)\
({\
FFPopup *popup = [FFPopup popupWithContentView:view];\
popup.showType = FFPopupShowType_GrowIn;\
popup.dismissType = FFPopupDismissType_ShrinkOut;\
popup.maskType = FFPopupMaskType_Dimmed;\
popup.shouldDismissOnBackgroundTouch = YES;\
popup.shouldDismissOnContentTouch = NO;\
[popup show];\
})\

//弹出view
#define PopupViewB(view)\
({\
FFPopup *popup = [FFPopup popupWithContentView:view];\
popup.showType = FFPopupShowType_GrowIn;\
popup.dismissType = FFPopupDismissType_ShrinkOut;\
popup.maskType = FFPopupMaskType_Dimmed;\
popup.shouldDismissOnBackgroundTouch = YES;\
popup.shouldDismissOnContentTouch = YES;\
[popup show];\
})\

//状态栏弹出通知
#define BarNotification(str)\
({\
[JDStatusBarNotification addStyleNamed:JDStatusBarStyleWarning\
                               prepare:^JDStatusBarStyle*(JDStatusBarStyle *style) {\
                                   style.barColor = [UIColor colorWithRed:0.900 green:0.734 blue:0.034 alpha:1.000];\
                                   style.textColor = [UIColor D_ColorStr:FontColor];\
                                   style.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];\
                                   style.heightForIPhoneX=JDStatusBarHeightForIPhoneXHalf;\
                                   return style;\
                               }];\
[JDStatusBarNotification showWithStatus:str dismissAfter:1 styleName:JDStatusBarStyleWarning];\
})\


#define BarNotificationB(str)\
({\
[JDStatusBarNotification addStyleNamed:JDStatusBarStyleWarning\
                            prepare:^JDStatusBarStyle*(JDStatusBarStyle *style) {\
                                style.barColor = [UIColor redColor];\
                                style.textColor = [UIColor whiteColor];\
                                style.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];\
                                style.heightForIPhoneX=JDStatusBarHeightForIPhoneXHalf;\
                                return style;\
                            }];\
[JDStatusBarNotification showWithStatus:str dismissAfter:1 styleName:JDStatusBarStyleWarning];\
})\

//状态栏菊花
#define NetworkActivityYES  dispatch_async(dispatch_get_main_queue(), ^{ [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; });
#define NetworkActivityNO   dispatch_async(dispatch_get_main_queue(), ^{ [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; });

//字体
#define Font(Name,Size)\
({\
UIFont*font=[UIFont fontWithName:Name size:Size];\
(font);\
})\


#define Px(pt)\
({\
CGFloat px = pt*96/72;\
(px);\
})\

//#define PT(px)\
//({\
//CGFloat pt = Screen_Width/375*px;\
//(px);\
//})\


//选择标签
#define JXCategoryView(arry,teger)\
({\
JXCategoryTitleView*categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];\
categoryView.titleFont=Font(Font_Arial, 14);\
categoryView.backgroundColor=[UIColor whiteColor];\
categoryView.titles = arry;\
categoryView.titleColorGradientEnabled = YES;\
categoryView.titleColor=[UIColor D_ColorStr:FontColorBlack];\
categoryView.titleSelectedColor=[UIColor D_ColorStr:NavigationColor];\
switch (teger) {\
    case 0:\
    {\
        categoryView.titleColorGradientEnabled = YES;\
        categoryView.titleLabelZoomEnabled = YES;\
        categoryView.titleLabelZoomScale = 1.15;\
        categoryView.titleLabelStrokeWidthEnabled = YES;\
        categoryView.selectedAnimationEnabled = YES;\
        categoryView.cellWidthZoomEnabled = YES;\
        categoryView.cellWidthZoomScale = 1.25;\
        categoryView.selectedAnimationDuration=0.15;\
    }\
        break;\
    case 1:\
    {\
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];\
        lineView.indicatorColor = [UIColor D_ColorStr:NavigationColor];\
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;\
        categoryView.indicators = @[lineView];\
    }\
        break;\
    default:\
        break;\
}\
(categoryView);\
})\


//下拉动画
#define SetRefreshImage(teger,header)\
({\
NSArray *idleImages=[NSArray array];\
if (teger==0) {\
    idleImages=@[GetImage(@"加载动态图-绿1"),GetImage(@"加载动态图-绿2"),GetImage(@"加载动态图-绿3"),GetImage(@"加载动态图-绿4")];\
}else if (teger==1){\
    idleImages=@[GetImage(@"加载动态图-灰1"),GetImage(@"加载动态图-灰2"),GetImage(@"加载动态图-灰3"),GetImage(@"加载动态图-灰4")];\
}else{\
    idleImages=@[GetImage(@"加载动态图-白1"),GetImage(@"加载动态图-白2"),GetImage(@"加载动态图-白3"),GetImage(@"加载动态图-白4")];\
}\
[header setImages:idleImages forState:MJRefreshStateIdle];\
[header setImages:idleImages forState:MJRefreshStatePulling];\
[header setImages:idleImages forState:MJRefreshStateRefreshing];\
header.lastUpdatedTimeLabel.hidden = YES;\
header.stateLabel.hidden = YES;\
})\

//上拉动画
#define SetRefreshFooterImage(teger,Footer)\
({\
NSArray *idleImages=[NSArray array];\
if (teger==0) {\
    idleImages=@[GetImage(@"加载动态图-绿1"),GetImage(@"加载动态图-绿2"),GetImage(@"加载动态图-绿3"),GetImage(@"加载动态图-绿4")];\
}else if (teger==1){\
    idleImages=@[GetImage(@"加载动态图-灰1"),GetImage(@"加载动态图-灰2"),GetImage(@"加载动态图-灰3"),GetImage(@"加载动态图-灰4")];\
}else{\
    idleImages=@[GetImage(@"加载动态图-白1"),GetImage(@"加载动态图-白2"),GetImage(@"加载动态图-白3"),GetImage(@"加载动态图-白4")];\
}\
Footer.refreshingTitleHidden = YES;\
[Footer setImages:idleImages forState:MJRefreshStateRefreshing];\
})\
//导航栏样式
#define StatusBarColor(teger)\
({\
if (teger==0) {\
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;\
self.navigationController.navigationBar.translucent = YES;\
[self.navigationController.navigationBar setBarTintColor:nil];\
[self.navigationController.navigationBar setShadowImage:nil];\
[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];\
self.navigationController.navigationBar.tintColor = [UIColor blackColor];\
SendNotice(@"ChangeLogoName", @"1");\
}else{\
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;\
self.navigationController.navigationBar.translucent = NO;\
[self.navigationController.navigationBar setBarTintColor:[UIColor D_ColorStr:NavigationColor]];\
[self.navigationController.navigationBar setShadowImage:[UIImage new]];\
[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];\
self.navigationController.navigationBar.tintColor = [UIColor whiteColor];\
}\
})\

//返回按钮
#define BackBtnStyle(teger)\
({\
UIImage *backButtonImage;\
if (teger==0) {\
    backButtonImage = [[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];\
}else{\
    backButtonImage = [[UIImage imageNamed:@"back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];\
}\
[UINavigationBar appearance].backIndicatorTransitionMaskImage = backButtonImage;\
[UINavigationBar appearance].backIndicatorImage = backButtonImage;\
})\


//是否登陆
#define IsLoading()\
({\
if ([User sharedInstance].UserXbid==nil||[[User sharedInstance].UserXbid isEqualToString:@""]||[User sharedInstance].UserJwt==nil||[[User sharedInstance].UserJwt isEqualToString:@""]) {\
LoadingC*vc=[[LoadingC alloc]init];\
[self.navigationController pushViewController:vc animated:YES];\
return;\
}\
})\

//是否登陆cell界面
#define IsLoadingCell()\
({\
if ([User sharedInstance].UserXbid==nil||[[User sharedInstance].UserXbid isEqualToString:@""]) {\
LoadingC*vc=[[LoadingC alloc]init];\
[self.owner.navigationController pushViewController:vc animated:YES];\
return;\
}\
})\

//防止重复点击
#define IsRepeatClick()\
({\
if (self.isRepeatClick==NO) {\
return;\
}else{\
    self.isRepeatClick=NO;\
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC));\
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){\
        self.isRepeatClick=YES;\
    });\
}\
})\


//店铺判断跳转
#define ShopJudgmentJump(Controller)\
({\
if ([[User sharedInstance].ShopType isEqualToString:@"店铺已过期"]){\
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的店铺已过期，请联系客服续费!" preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];\
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"联系客服" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {\
    if ([User sharedInstance].CustomerService!=nil) {\
        ChatScreenController* chatVC= [[ ChatScreenController  alloc] init];\
        ChatUser *ChatUserModel = [[ChatUser alloc] init];\
        ChatUserModel.item=[User sharedInstance].CustomerService;\
        chatVC.user = ChatUserModel;\
        [Controller.navigationController pushViewController:chatVC animated:YES];\
    }else{\
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];\
        dict[@"userXbid"]=[User sharedInstance].UserXbid;\
        dict[@"connectorxbid"]=@"2965";\
        [DyTools post:RequestLink(Message_Personalstatus) heard:[User sharedInstance].UserJwt params:dict success:^(id responseObj) {\
            NSDictionary *nsdict=[StringJson dicValueData:responseObj];\
            NSDictionary *dict =  [StringJson dicValue:nsdict[@"object"][@"object"]];\
            ChatScreenController* chatVC= [[ ChatScreenController  alloc] init];\
            [User sharedInstance].CustomerService=[ChatListModel mj_objectWithKeyValues: dict];\
            ChatUser *ChatUserModel = [[ChatUser alloc] init];\
            ChatUserModel.item=[User sharedInstance].CustomerService;\
            chatVC.user = ChatUserModel;\
            [Controller.navigationController pushViewController:chatVC animated:YES];\
        } failure:^(NSError *error) {\
        }];\
    }\
}];\
[alertController addAction:cancelAction];\
[alertController addAction:okAction];\
[Controller presentViewController:alertController animated:YES completion:nil];\
return;\
}\
if (![[User sharedInstance].ShopType isEqualToString:@"有开通店铺"]){\
    TenantsNewA*vc=[[TenantsNewA alloc]init];\
    [Controller.navigationController pushViewController:vc animated:YES];\
    return;\
}\
})\

#define CallPhonee(ViewController,phonenumber)\
({\
if([[[UIDevice currentDevice]systemVersion] floatValue] >=10.3) {\
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phonenumber]] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {\
        if (!success) {\
        }\
    }];\
}else{\
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",phonenumber] message:nil preferredStyle:UIAlertControllerStyleAlert];\
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];\
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phonenumber]] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {\
            if (!success) {\
            }\
        }];\
    }];\
    [alertController addAction:cancelAction];\
    [alertController addAction:okAction];\
    [ViewController presentViewController:alertController animated:YES completion:nil];\
}\
})\

//#define ImageTest @"https://jzt1.oss-cn-shanghai.aliyuncs.com/photot_name_24B7C92F-025E-4E96-8A3D-187EDBCFA184.jpg"

#define VideoTest @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"

#pragma mark - 易忘工具
//@"\"success\""
//self.NewPurchasingArry=(NSMutableArray *)[[self.NewPurchasingArry reverseObjectEnumerator] allObjects];
//Arial-BoldMT

//nameStr=[nameStr substringWithRange:NSMakeRange(1,nameStr.length-2)];
//nameStr = [nameStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//nameStr = [nameStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];

////获取全局并发队列
//dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
////创建队列组
//dispatch_group_t group = dispatch_group_create();
//
//dispatch_group_enter(group);
//dispatch_group_async(group, queue, ^{
//    [imageview sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        _image=imageview.image;
//        dispatch_group_leave(group);
//    }];
//});
//
////队列组结束通知
//dispatch_group_notify(group, queue, ^{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (_image != nil) {
//            _messageSize = (_image.size.width > WIDTH_SCREEN * 0.5 ? CGSizeMake(WIDTH_SCREEN * 0.5, WIDTH_SCREEN * 0.5 / _image.size.width * _image.size.height) : _image.size);
//            _messageSize = (_messageSize.height > 60 ? (_messageSize.height < 200 ? _messageSize : CGSizeMake(_messageSize.width, 200)) : CGSizeMake(60.0 / _messageSize.height * _messageSize.width, 60));
//        }
//        else {
//            _messageSize = CGSizeMake(0, 0);
//        }
//    });
//});

//导航栏返回拦截
//-(BOOL)navigationShouldPopOnBackButton
//{
//    return YES;
//}

//    if (IS_IPHONE) {
//        DLog(@"这是手机")
//    }else if (IS_IPAD){
//        DLog(@"这是ipad")
//    }


//打印frame
////    DLog(@"view======%@",NSStringFromCGRect(view.frame));
//    DLog(@"CollectionView======%@",NSStringFromCGRect(self.CollectionView.frame));

//打印字体
//NSArray *fontArr = UIFont.familyNames;
//for (NSString *fontName in fontArr) {
//    NSLog(@"%@", fontName);
//}

//gif 图片过大, 不在内存进行缓存

//随机数
//-(int)getRandomNumber:(int)from to:(int)to
//{
//    return (int)(from + (arc4random () % (to - from + 1)));
//}


#pragma mark - 刻刀支持
#ifdef WMGraverDebug
#define WMGLog(fmt, ...) NSLog((@"[graver-log]" fmt), ##__VA_ARGS__);
#else
#define WMGLog(...)
#endif

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

// sample: Designer - #FF0000, We - HEXCOLOR(0xFF0000)
#define WMGHEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]

#endif /* FunctionH_h */
