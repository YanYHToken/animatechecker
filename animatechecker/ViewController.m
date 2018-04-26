//
//  ViewController.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ViewController.h"
#import "PieceModel.h"
#import "AnimateDatas.h"
#import "ChessPieceView.h"

@interface ViewController ()
@property(nonatomic, strong)NSArray *frames;
@property(nonatomic, strong)NSMutableArray<PieceModel *> *chessPieceModels;
@property(nonatomic, strong)UIImageView *game_board_view;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chessPieceModels = [[NSMutableArray alloc] init];
    
    UIImage *game_bg = [UIImage imageNamed:@"board"];
    self.game_board_view = [[UIImageView alloc] initWithImage:game_bg];
    [self.view addSubview:self.game_board_view];
    CGSize size = game_bg.size;
    
    int swidth = self.view.frame.size.width;
    int sheight = self.view.frame.size.height;
    int iheight = sheight/(size.width/swidth);
    self.game_board_view.frame = CGRectMake(0, (sheight-iheight)/2, swidth, iheight);
    self.frames = [self createFrames:self.game_board_view.bounds];
    [self createPieces];
}


- (NSArray *)createFrames:(CGRect)bounds
{
    
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGFloat item_width = bounds.size.width / (COL_7 * 1.0);
    CGFloat item_height = bounds.size.height / (ROW_9 * 1.0);
    for (int row_index = 0; row_index < ROW_9; row_index++)
    {
        NSMutableArray *rows = [NSMutableArray array];
        for (int col_index = 0; col_index < COL_7; col_index++)
        {
            CGFloat x = item_width * col_index;
            CGFloat y = item_height * row_index;
            CGRect frame = CGRectMake(x, y, item_width, item_height);
            NSValue *value = [NSValue valueWithCGRect:frame];
            [rows addObject:value];
//            UIView *view = [[UIView alloc] initWithFrame:frame];
//            UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//            view.backgroundColor = randomColor;
//            [self.game_board_view addSubview:view];
        }
        [frames addObject:[rows copy]];
    }
    return [frames copy];
}

- (void)createPieces
{
    [self createChessPieceModel:@"black_lion" animal:[AnimateDatas LION] chess_piece_index:BLACK_LION col_index:0 row_index:0];
    [self createChessPieceModel:@"black_tiger" animal:[AnimateDatas TIGER] chess_piece_index:BLACK_TIGER col_index:6 row_index:0];
    [self createChessPieceModel:@"black_dog" animal:[AnimateDatas DOG] chess_piece_index:BLACK_DOG col_index:1 row_index:1];
    [self createChessPieceModel:@"black_cat" animal:[AnimateDatas CAT] chess_piece_index:BLACK_CAT col_index:5 row_index:1];
    [self createChessPieceModel:@"black_mouse" animal:[AnimateDatas MOUSE] chess_piece_index:BLACK_MOUSE col_index:0 row_index:2];
    [self createChessPieceModel:@"black_leopard" animal:[AnimateDatas LEOPARD] chess_piece_index:BLACK_LEOPARD col_index:2 row_index:2];
    [self createChessPieceModel:@"black_wolf" animal:[AnimateDatas WOLF] chess_piece_index:BLACK_WOLF col_index:4 row_index:2];
    [self createChessPieceModel:@"black_elephant" animal:[AnimateDatas ELEPHANT] chess_piece_index:BLACK_ELEPHANT col_index:6 row_index:2];
    
    
    [self createChessPieceModel:@"red_lion" animal:[AnimateDatas LION] chess_piece_index:RED_LION col_index:6 row_index:8];
    [self createChessPieceModel:@"red_tiger" animal:[AnimateDatas TIGER] chess_piece_index:RED_TIGER col_index:0 row_index:8];
    [self createChessPieceModel:@"red_dog" animal:[AnimateDatas DOG] chess_piece_index:RED_DOG col_index:5 row_index:7];
    [self createChessPieceModel:@"red_cat" animal:[AnimateDatas CAT] chess_piece_index:RED_CAT col_index:1 row_index:7];
    [self createChessPieceModel:@"red_mouse" animal:[AnimateDatas MOUSE] chess_piece_index:RED_MOUSE col_index:6 row_index:6];
    [self createChessPieceModel:@"red_leopard" animal:[AnimateDatas LEOPARD] chess_piece_index:RED_LEOPARD col_index:4 row_index:6];
    [self createChessPieceModel:@"red_wolf" animal:[AnimateDatas WOLF] chess_piece_index:RED_WOLF col_index:2 row_index:6];
    [self createChessPieceModel:@"red_elephant" animal:[AnimateDatas ELEPHANT] chess_piece_index:RED_ELEPHANT col_index:0 row_index:6];
    for (PieceModel *model in self.chessPieceModels) {
        ChessPieceView *btn = [[ChessPieceView alloc] initWithModel:model];
        [self.game_board_view addSubview:btn];
        btn.frame = model.frame;
    }
}

- (void)createChessPieceModel:(NSString *)img_name
                       animal:(NSString *)animal
            chess_piece_index:(int)chess_piece_index
                    col_index:(int)col_index
                    row_index:(int)row_index
{
    PieceModel *model = [PieceModel modelWith:img_name
                                                 animal:animal
                                      chess_piece_index:chess_piece_index
                                              col_index:col_index
                                              row_index:row_index];
    [model piecePosition:self.frames[row_index][col_index]];
    [self.chessPieceModels addObject:model];
}



@end
