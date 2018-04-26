//
//  Animates.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "AnimateDatas.h"

@implementation AnimateDatas

+ (NSString *)MOUSE
{
    return @"MOUSE";
}

+ (NSString *)CAT
{
    return @"CAT";
}

+ (NSString *)DOG
{
    return @"DOG";
}

+ (NSString *)WOLF
{
    return @"WOLF";
}

+ (NSString *)LEOPARD
{
    return @"LEOPARD";
}

+ (NSString *)TIGER
{
    return @"TIGER";
}

+ (NSString *)LION
{
    return @"LION";
}

+ (NSString *)ELEPHANT
{
    return @"ELEPHANT";
}


+ (NSArray<NSString *> *)animates
{
    static NSArray<NSString *> *datas;
    if(!datas)datas = @[[AnimateDatas MOUSE], [AnimateDatas CAT], [AnimateDatas WOLF], [AnimateDatas DOG], [AnimateDatas LEOPARD], [AnimateDatas TIGER], [AnimateDatas LION], [AnimateDatas ELEPHANT]];
    return datas;
}



@end
