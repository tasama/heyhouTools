//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  Macro.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark NSLog

#ifdef DEBUG        //!<如果在Debug环境中 LPLog等于NSLog

#define XUNLog(...)   do                                                                             \
{                                                                               \
NSLog(__VA_ARGS__);                                                         \
printf("\nfile:%s line:%d func:%s\n\n",                                     \
[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent.UTF8String,   \
__LINE__, __func__);                                                        \
}while(0)
#else               //!<如果在Release环境中 GFLog 没有实际意义
#define LPLog(...)
#endif

#ifdef __cplusplus

#define XUNExtern extern "C"

#else

#define XUNExtern extern

#endif

#define kScreenBounds   [UIScreen mainScreen].bounds
#define kScreenWidth    kScreenBounds.size.width
#define kScreenHeight   kScreenBounds.size.height


#endif /* Macro_h */
