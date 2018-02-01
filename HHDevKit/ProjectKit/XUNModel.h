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
//  XUNModel.h
//  ProjectKit
//
//  Created by xun on 16/12/13.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XUNModelProtocol <NSObject>

+ (NSDictionary *)replaceDict;

+ (NSDictionary *)classDict;

@end

@interface XUNModel : NSObject <XUNModelProtocol>

+ (id)objWithJsonObj:(id)jsonObj;

- (NSString *)jsonString;

- (NSDictionary *)keysAndValues;

@end
