//
//  Animates.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <Foundation/Foundation.h>

/* match index to particular chess piece */
static const int RED_MOUSE = 0;
static const int RED_CAT = 1;
static const int RED_WOLF = 2;
static const int RED_DOG = 3;
static const int RED_LEOPARD = 4;
static const int RED_TIGER = 5;
static const int RED_LION = 6;
static const int RED_ELEPHANT = 7;
static const int BLACK_MOUSE = 8;
static const int BLACK_CAT = 9;
static const int BLACK_WOLF = 10;
static const int BLACK_DOG = 11;
static const int BLACK_LEOPARD = 12;
static const int BLACK_TIGER = 13;
static const int BLACK_LION = 14;
static const int BLACK_ELEPHANT = 15;

@interface Animates : NSObject

//象、狮、虎、豹、狼、狗、猫；
+ (NSString *)MOUSE;

+ (NSString *)CAT;

+ (NSString *)DOG;

+ (NSString *)WOLF;

+ (NSString *)LEOPARD;

+ (NSString *)TIGER;

+ (NSString *)LION;

+ (NSString *)ELEPHANT;

+ (NSArray<NSString *> *)animates;

@end
