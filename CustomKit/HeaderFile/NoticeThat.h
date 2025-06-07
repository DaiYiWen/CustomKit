//
//  NoticeThat.h
//  Pyramid
//
//  Created by apple on 2021/3/16.
//

#ifndef NoticeThat_h
#define NoticeThat_h


//接受通知
#define ReceiveNotice(function,str)\
({\
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(function:) name:str object:nil];\
})\


//发送通知(带参数)
#define SendNotice(name,str)\
({\
[[NSNotificationCenter defaultCenter]postNotificationName:name object:nil userInfo:@{@"parameter":str}];\
})\


//移除通知
#define RemoveNotice(str)\
({\
[[NSNotificationCenter defaultCenter]removeObserver:self name:str object:nil];\
})\

/**
*  所有通知宏
*  避免重定义通知方法
*/


/**
*  状态
*/

#define Notice_LoginSuccessful                                 @"Notice_LoginSuccessful"                           //登录成功
#define Notice_LoginSuccessfulB                                @"Notice_LoginSuccessfulB"                          //登录成功B方案
#define Notice_LoginSuccessfulEaseIM                           @"Notice_LoginSuccessfulEaseIM"                     //环信登录成功
#define Notice_LoadingOUT                                      @"Notice_LoadingOUT"                                //退出登录
#define Notice_RepeatLogin                                     @"Notice_RepeatLogin"                               //重复登录
#define Notice_NotLoggedIn                                     @"Notice_NotLoggedIn"                               //未登录
#define Notice_RegisteredOK                                    @"Notice_RegisteredOK"                              //注册成功
#define Notice_unreadMessage                                   @"Notice_unreadMessage"                             //获取未读消息数量
#define Notice_WeixinLogin                                     @"Notice_WeixinLogin"                               //登录成功
#define Notice_isReview                                        @"Notice_isReview"                                  //审核模式
#define Notice_isReviewNO                                      @"Notice_isReviewNO"                                //不是审核模式

#pragma mark - 退出登录类型
#define Notice_loadingOutYiDi                                 @"Notice_loadingOutYiDi"                         //其它设备登录
#define Notice_loadingOutDongJie                              @"Notice_loadingOutDongJie"                      //账户冻结


#define Notice_applicationDidEnterBackground                   @"Notice_applicationDidEnterBackground"             //程序进入后台
#define Notice_IntoTheFrontDesk                                @"Notice_IntoTheFrontDesk"                          //程序进入前台
#define Notice_Activation                                      @"Notice_Activation"                                //激活
#define Notice_NoActivation                                    @"Notice_NoActivation"                              //取消激活

#define Notice_4G                                              @"Notice_4G"                                        //4G网络
#define Notice_WIFI                                            @"Notice_WIFI"                                      //wifi网络
#define Notice_NoNetwork                                       @"Notice_NoNetwork"                                 //无网络断网



/**
*  业务
*/

#endif /* NoticeThat_h */
