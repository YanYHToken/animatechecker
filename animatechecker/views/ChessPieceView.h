//
//  Pieces.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieceModel.h"

@interface ChessPieceView : UIButton

@property(nonatomic, strong)PieceModel *model;

- (instancetype)initWithModel:(PieceModel *)model;

- (NSString *)animal;

- (BOOL)team;

- (int)chess_piece_index;

@end
