//
//  ChessPieceModel.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "PieceModel.h"

@implementation PieceModel

- (void)modelWith:(NSString *)img_name animal:(NSString *)animal chess_piece_index:(int)chess_piece_index x_index:(int)x_index y_index:(int)y_index
{
    self.img_name = img_name;
    self.animal = animal;
    self.x_index = x_index;
    self.y_index = y_index;
    self.chess_piece_index = chess_piece_index;
    self.team = self.chess_piece_index < 8;
    NSLog(@"%@ was create", img_name);
    self.chess_piece_index = chess_piece_index % 8;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _alive = NO;
    }
    return self;
}


- (void)capture
{
    _alive = NO;
    [self.chessView removeFromSuperview];
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
    self.chessView.image = [UIImage imageNamed:img_name];
}

- (UIImageView *)chessView
{
    if(!_chessView)
    {
        _chessView = [[UIImageView alloc] init];
        _chessView.frame = _frame;
        _chessView.layer.borderWidth = 3;
        _chessView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _chessView;
}

- (void)updatePosition:(PieceModel *)model
{
    CGRect frame = self.frame;
    int y_index = self.y_index;
    int x_index = self.x_index;
    self.x_index = model.x_index;
    self.y_index = model.y_index;
    self.frame = model.frame;
    model.x_index = x_index;
    model.y_index = y_index;
    model.frame = frame;
}

- (void)setFrame:(CGRect)frame
{
    _frame = frame;
    _chessView.frame = CGRectMake(frame.origin.x + 5, frame.origin.y + 5, frame.size.width-10, frame.size.height-10);
}

- (void)selected:(BOOL)select
{
    if(!select)
    {
        _chessView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    else
    {
        _chessView.layer.borderColor = [UIColor blueColor].CGColor;
    }
}

@end
