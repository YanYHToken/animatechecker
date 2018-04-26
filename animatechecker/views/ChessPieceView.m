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
        self.layer.borderWidth = 4;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if(selected)
    {
        self.layer.borderColor = [UIColor blueColor].CGColor;
    }
    else
    {
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (NSString *)animal
{
    return self.model.animal;
}
- (BOOL)team
{
    return self.model.team;
}

- (int)chess_piece_index
{
    return self.model.chess_piece_index;
}
@end
