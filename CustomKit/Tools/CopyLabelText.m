//
//  CopyLabel1.m
//  YMGK
//
//  Created by XBDS2017 on 2019/4/26.
//  Copyright © 2019 XBDS2017. All rights reserved.
//

#import "CopyLabelText.h"

@interface CopyLabelText ()
@property (nonatomic, strong) UIPasteboard *pasteBoard;
@property (nonatomic,strong) UIMenuController *menuController;
@end

@implementation CopyLabelText

- (UIMenuController *)menuController{
    if (!_menuController) {
        UIMenuItem *copyMenuItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyAction:)];
        //    UIMenuItem *pasteMenueItem = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(pasteAction:)];
        //    UIMenuItem *cutMenuItem = [[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(cutAction:)];
        _menuController = [UIMenuController sharedMenuController];
        [_menuController setMenuItems:[NSArray arrayWithObjects:copyMenuItem, nil]];
        [_menuController setTargetRect:self.frame inView:self.superview];
    }
    return _menuController;
}

- (void)dealloc
{
    RemoveNotice(UIMenuControllerWillHideMenuNotification);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.numberOfLines = 0;
        [self attachLongPress];
        self.pasteBoard = [UIPasteboard generalPasteboard];
        ReceiveNotice(WillHideMenu, UIMenuControllerWillHideMenuNotification);
    }
    return self;
}

- (void)attachLongPress{
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCellHandle:)];
    [self addGestureRecognizer:longPressGesture];
}

-(void)longPressCellHandle:(UILongPressGestureRecognizer *)gesture
{
    [self becomeFirstResponder];
    if (gesture.state==UIGestureRecognizerStateBegan) {
        [self.menuController setMenuVisible:YES animated:YES];
        self.backgroundColor=[[UIColor D_ColorStr:[UIColor redColor]] colorWithAlphaComponent:0.35];
    }
    
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction:)) {
        return YES;
    }
    if (action == @selector(pasteAction:)) {
        return YES;
    }
    if (action == @selector(cutAction:)) {
        return YES;
    }
    return NO; //隐藏系统默认的菜单项
    
}

- (void)copyAction:(id)sender {
    self.pasteBoard.string = self.text;
//    DLog(@"粘贴的内容为%@", self.pasteBoard.string);
}

- (void)pasteAction:(id)sender {
    self.text = self.pasteBoard.string;
}

- (void)cutAction:(id)sender  {
    self.pasteBoard.string = self.text;
    self.text = nil;
}

-(void)WillHideMenu:(id)type{
    self.backgroundColor=[UIColor clearColor];
//    [self.menuController setMenuVisible:NO];
}

- (void)hide{
//    [self.menuController update];
//    [self.menuController setMenuVisible:NO];
}

@end
