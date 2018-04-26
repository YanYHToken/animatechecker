//
//  Pieces.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ChessPieceView.h"

@implementation ChessPieceView

- (instancetype)initWithModel:(PieceModel *)model
{
    self = [super init];
    if(self)
    {
        self.model = model;
        [self setImage:model.img forState:UIControlStateNormal];
        [self setImage:model.img forState:UIControlStateHighlighted];
        [self setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    }
    return self;
}

@end
