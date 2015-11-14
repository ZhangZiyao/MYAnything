//
//  UIDefines.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/13.
//  Copyright © 2015年 soez. All rights reserved.
//

#ifndef UIDefines_h
#define UIDefines_h

#pragma mark - 颜色
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define BlueBtnColor        [UIColor colorWithRed:3/255.0f green:155/255.0f blue:229/255.0f alpha:1.0f]
#define GreenBtnColor        [UIColor colorWithRed:142/255.f green:195/255.f blue:31/255.f alpha:1]
#define BGColor         [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]

#pragma mark - 
#define MAINSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define MAINSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define NAV_HEIGHT 64.f


#endif /* UIDefines_h */
