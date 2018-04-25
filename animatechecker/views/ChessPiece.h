//
//  Pieces.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChessPieceModel.h"
@interface ChessPiece : UIButton

@property(nonatomic, strong)ChessPieceModel *model;

- (instancetype)initWithModel:(ChessPieceModel *)model;

@end
