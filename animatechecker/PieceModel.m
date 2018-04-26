//
//  ChessPieceModel.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "PieceModel.h"

@implementation PieceModel

+ (PieceModel *)modelWith:(NSString *)img_name
                        animal:(NSString *)animal
             chess_piece_index:(int)chess_piece_index
                     col_index:(int)col_index
                     row_index:(int)row_index
{
    PieceModel *model = [[PieceModel alloc] init];
    model.img_name = img_name;
    model.animal = animal;
    model.row_index = row_index;
    model.col_index = col_index;
    model.chess_piece_index = chess_piece_index;
    model.team = model.chess_piece_index < 8;
    NSLog(@"%@ was create", img_name);
    return model;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _alive = YES;
    }
    return self;
}


- (void)piecePosition:(NSValue *)value
{
    self.frame = value.CGRectValue;
}

- (void)capture
{
    _alive = NO;
}

- (void)revive
{
    _alive = YES;
}

- (NSString *)description
{
    NSString *name = [self.animal lowercaseString];
    
    if (self.team)
    {
        name = [NSString stringWithFormat:@"red_%@", name];
    }
    else
    {
        name = [NSString stringWithFormat:@"black_%@", name];
    }
    return name;
}

- (void)setImg_name:(NSString *)img_name
{
    _img_name = img_name;
    self.img = [UIImage imageNamed:img_name];
}
@end
