//
//  ChessPieceModel.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ChessPieceModel : NSObject
@property(nonatomic, assign)BOOL alive;
@property(nonatomic, copy)NSString *animal;
@property(nonatomic, assign)BOOL team; // true if red, false if black
@property(nonatomic, assign)CGFloat x;
@property(nonatomic, assign)CGFloat y;
@property(nonatomic, copy)NSString *img_name;
@property(nonatomic, strong)UIImage *img;
@end
