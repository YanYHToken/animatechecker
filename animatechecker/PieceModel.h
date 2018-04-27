//
//  ChessPieceModel.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    Red_Team = 0,
    Black_Team = 1,
    Unknow_Team = 2
}Team;

@interface PieceModel : NSObject

@property(nonatomic, assign, readonly)BOOL alive;

@property(nonatomic, copy)NSString *animal;

@property(nonatomic, assign)Team team;

@property(nonatomic, assign)CGRect frame;

@property(nonatomic, assign)int y_index;

@property(nonatomic, assign)int x_index;

@property(nonatomic, assign)int chess_piece_index;

@property(nonatomic, copy)NSString *img_name;

@property(nonatomic, strong)UIImageView *chessView;

- (void)modelWith:(NSString *)img_name animal:(NSString *)animal chess_piece_index:(int)chess_piece_index x_index:(int)x_index y_index:(int)y_index;

- (void)capture;

- (void)revive;

- (void)updatePosition:(PieceModel *)model;

- (void)selected:(BOOL)select;

@end
