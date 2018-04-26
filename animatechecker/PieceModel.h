//
//  ChessPieceModel.h
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PieceModel : NSObject

@property(nonatomic, assign, readonly)BOOL alive;

@property(nonatomic, copy)NSString *animal;

@property(nonatomic, assign)BOOL team; // true if red, false if black

@property(nonatomic, assign)CGRect frame;

@property(nonatomic, assign)int col_index;

@property(nonatomic, assign)int row_index;

@property(nonatomic, assign)int chess_piece_index;

@property(nonatomic, copy)NSString *img_name;

@property(nonatomic, strong)UIImage *img;

+ (PieceModel *)modelWith:(NSString *)img_name
                        animal:(NSString *)animal
             chess_piece_index:(int)chess_piece_index
                     col_index:(int)col_index
                     row_index:(int)row_index;

- (void)piecePosition:(NSValue *)value;

- (void)capture;

- (void)revive;

@end
