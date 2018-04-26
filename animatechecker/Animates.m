//
//  Animates.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "Animates.h"

@implementation Animates

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
    if(!datas)datas = @[[Animates MOUSE], [Animates CAT], [Animates WOLF], [Animates DOG], [Animates LEOPARD], [Animates TIGER], [Animates LION], [Animates ELEPHANT]];
    return datas;
}



@end
