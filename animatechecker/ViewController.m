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
@property(nonatomic, assign)CGFloat item_width;
@property(nonatomic, assign)CGFloat item_height;
@property(nonatomic, assign)BOOL red_in_turn;
@property(nonatomic, assign)int move_to_col_index;
@property(nonatomic, assign)int move_to_row_index;
@property(nonatomic, strong)ChessPieceView *selectedPiece;
@property(nonatomic, strong)ChessPieceView *capturePiece;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chessPieceModels = [[NSMutableArray alloc] init];
    self.red_in_turn = YES;
    UIImage *game_bg = [UIImage imageNamed:@"board"];
    self.game_board_view = [[UIImageView alloc] initWithImage:game_bg];
    [self.view addSubview:self.game_board_view];
    CGSize size = game_bg.size;
    
    int swidth = self.view.frame.size.width;
    int sheight = self.view.frame.size.height;
    int iheight = sheight/(size.width/swidth);
    self.game_board_view.frame = CGRectMake(0, (sheight-iheight)/2, swidth, iheight);
    self.game_board_view.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.game_board_view addGestureRecognizer:singleTap];
    self.frames = [self createFrames:self.game_board_view.bounds];
    [self createPieces];
}


- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    if(!self.selectedPiece)return;//没有选中棋子
    CGPoint point = [tap locationInView:self.game_board_view];
    NSLog(@"handleSingleTap ! pointx:%f,y:%f",point.x,point.y);
    int row_index = point.y/self.item_height;
    int col_index = point.x/self.item_width;
    int border = 10;
    self.move_to_col_index = self.move_to_row_index = -1;
    if((self.item_height * row_index + border < point.y) &&
       (self.item_width * col_index + border < point.x) &&
       (self.item_height * (row_index + 1) - border > point.y)  &&
       (self.item_height * (col_index + 1) - border > point.x))
    {
        NSLog(@"selection in row_index = %i col_index = %i", row_index, col_index);
        self.move_to_col_index = col_index;
        self.move_to_row_index = row_index;
        [self movePiece:self.selectedPiece.model.row_index curY:self.selectedPiece.model.col_index nextX:self.move_to_row_index nextY:self.move_to_col_index];
    }
}

- (NSArray *)createFrames:(CGRect)bounds
{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    self.item_width = bounds.size.width / (COL_7 * 1.0);
    self.item_height = bounds.size.height / (ROW_9 * 1.0);
    for (int row_index = 0; row_index < ROW_9; row_index++)
    {
        NSMutableArray *rows = [NSMutableArray array];
        for (int col_index = 0; col_index < COL_7; col_index++)
        {
            CGFloat x = self.item_width * col_index;
            CGFloat y = self.item_height * row_index;
            CGRect frame = CGRectMake(x, y, self.item_width, self.item_height);
            NSValue *value = [NSValue valueWithCGRect:frame];
            [rows addObject:value];
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
        [btn addTarget:self action:@selector(chessSelection:) forControlEvents:UIControlEventTouchUpInside];
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


- (void)chessSelection:(ChessPieceView *)view
{
    if(!self.selectedPiece)
    {
        [self.selectedPiece setSelected:NO];
        self.selectedPiece = view;
        [self.selectedPiece setSelected:YES];
    }
    else
    {
        if( [view team] == [self.selectedPiece team])
        {
            [self.selectedPiece setSelected:NO];
            self.selectedPiece = view;
            [self.selectedPiece setSelected:YES];
        }
        else
        {
            [self.capturePiece setSelected:NO];
            self.capturePiece = view;
            NSLog(@"chess was selection %@", [view.model description]);
            [self.capturePiece setSelected:YES];
        }
    }
    NSLog(@"chess was selection %@", [view.model description]);

}



/**
 * Given the current position of a chess piece and the position of it's
 * target, captures piece returns true if capture is valid. returns false
 * and does nothing if capture is invalid
 * @param curX x coordinate of chess piece
 * @param curY y coordinate of chess piece
 * @param nextX x coordinate of target piece
 * @param nextY y coordinate of target piece
 * @param cur current chess piece
 * @return true if piece was captured, false if capture is not valid
 */
- (BOOL)capture:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY cur:(ChessPieceView *) cur
{
    NSString *a = [cur animal];
    ChessPieceView *target = self.capturePiece;
    NSString *b = [target animal];
    // return false if target chess piece has higher rank
    // unless cur is mouse or unless target is in trap
    if ([cur chess_piece_index] - [target chess_piece_index] < 0
        && ![a isEqualToString:[AnimateDatas MOUSE]]
        && ! [self inTrap:target x:nextX y:nextY])
    {
        return NO;
    }
    // mouse can only capture elephant and mouse
    // note a mouse cannot capture the other mouse unless they are either
    // both in the river, or both on land
    if (([a isEqualToString:[AnimateDatas MOUSE]]
         && ![b isEqualToString:[AnimateDatas ELEPHANT]]
         && ![b isEqualToString:[AnimateDatas MOUSE]])
        || ([self inRiver:curX y:curY] != [self inRiver:nextX y:nextY])){
        return NO;
    }
    // elephant cannot capture mouse
    if ([a isEqualToString:[AnimateDatas ELEPHANT]]
        && [b isEqualToString:[AnimateDatas MOUSE]]) {
        return NO;
    }
    // capture target piece
    [target.model capture];
    return YES;
}

/**
 * Checks if next location is accessible by chess piece
 * Note it does not take into account whether that location is occupied by
 * another chess piece
 * @param a chess piece's animal
 * @param curX current X coordinate
 * @param curY current Y coordinate
 * @param nextX intended X coordinate
 * @param nextY intended Y coordinate
 * @return BOOL
 */
- (BOOL)accessible:(NSString *)a curX:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    //如果预期区域超过一步，返回错误
    //狮子和老虎如果在河边例外
    if (![self oneStepAway:curX curY:curY nextX:nextX nextY:nextY]
        && ![self jumpException:a curX:curX curY:curY nextX:nextX nextY:nextY]) {
        return NO;
    }
    //如果预期的区域在河中，则返回错误，而动物不是鼠标。
    if ([self inRiver:nextX y:nextY] && ! [a isEqualToString:[AnimateDatas MOUSE]]) {
        return NO;
    }
    //如果预定位置是棋子自己的巢穴，则返回假。
    if ([self inOwnDen:self.selectedPiece x:nextX y:nextY]) {
        return NO;
    }
    return YES;
}


/** 棋子是不是一步到位 */
- (BOOL)oneStepAway:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    return ((abs(nextX - curX) == 1 && nextY == curY) || (abs(nextY - curY) == 1 && nextX == curX));
}

/** 如果区域在河中，则返回真。取其x，y坐标*/
- (BOOL)inRiver:(int)x y:(int)y
{
    return (((x > 0 && x < 3) || (x > 3 && x < 6)) && (y > 2 && y < 6));
}

/** 如果棋子在对手的巢穴中，给出一个棋子和目标X和Y坐标，则返回真。*/
- (BOOL)inOpponentDen:(ChessPieceView *)cp x:(int)x y:(int)y
{
    return ([cp team] && x == 3 && y == 0) || (![cp team] && x == 3 && y == 8);
}

/**如果棋子将在自己的巢穴中，给出一个棋子和目标X和Y坐标，则返回真。*/
- (BOOL)inOwnDen:(ChessPieceView *) cp x:(int)x y:(int)y
{
    return (![cp team] && x == 3 && y == 0) || ([cp team] && x == 3 && y == 8);
}

/** 如果棋子在陷阱中，给出一个棋子，它的当前x和y坐标返回true*/
- (BOOL)inTrap:(ChessPieceView *) cp x:(int)x y:(int)y
{
    if ([cp team])
    {
        return (x == 2 && y == 0) || (x == 3 && y == 1) || (x == 4 && y == 0);
    }
    else
    {
        return (x == 2 && y == 8) || (x == 3 && y == 7) || (x == 4 && y == 8);
    }
}

/**
 * 如果狮子和老虎能跳过河，除非他们没有老鼠，否则就要返回真实。
 */
- (BOOL)jumpException:(NSString *)a curX:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    // 如果动物不是狮子或老虎，则返回假
    if (![a isEqualToString:[AnimateDatas LION]] && ![a isEqualToString:[AnimateDatas TIGER]]) {
        return NO;
    }
    //检查狮子/老虎是否在河的左边或右边
    //和打算跳转到另一边。
    if ((curX == 0 || curX == 3 || curX == 6) && (curY > 2 && curY < 6)) {
        // 如果预期的位置横跨河流返回真实
        if (abs(nextX - curX) == 3 && (nextY == curY)) {
            // 检查河里是否有一只老鼠挡住了跳水
            for (int i = 1; i < 3; i++) {
                int sign = (nextX - curX) % 2;
                NSValue *value = self.frames[curX + sign * i][curY];
                if (value)
                {
                    return NO;
                }
            }
            return YES;
        }
    }
    // 检查狮子/老虎是否在河的上方或下方，意欲跳到
    //对方一边
    if ((curY == 2 || curY == 6) && (curX == 1 || curX == 2 || curX == 4 || curX == 5)) {
        if (abs(nextY - curY) == 4 && (nextX == curX)) {
            // 检查河里是否有一只老鼠挡住了跳水
            for (int i = 1; i < 4; i++) {
                int sign = (nextY - curY) % 3;
                if (self.frames[curX][curY + sign * i])
                {
                    return NO;
                }
            }
            return YES;
        }
    }
    // else return false
    return NO;
}

/**
 * This method takes in a current position, and an intended position.
 * If the move is legal, it moves the chess piece accordingly and returns
 * true. It also updates win variable if game was won with that move.
 * Otherwise it does nothing and returns false.
 * @param curX current x coordinate
 * @param curY current y coordinate
 * @param nextX intended x coordinate
 * @param nextY intended y coordinate
 * @return BOOL
 */
- (BOOL)movePiece:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    ChessPieceView *cur = self.selectedPiece;
    //当前没有选中的棋子
    if (!cur)
    {
        return NO;
    }
    // 下一个位置是同一个位置直接返回NO
    if (curX == nextX && curY == nextY)
    {
        return NO;
    }
    
    // 如果棋子不能访问下一步，则返回NO
    if (![self accessible:[cur animal] curX:curX curY:curY nextX:nextX nextY:nextY])
    {
        return NO;
    }
    
    //捕获目标，如果方块被对手棋子占据，则可以
    //由Cur捕获。目标方占用时返回错误
    //捕获无效
    if (![self capture:curX curY:curY nextX:nextX nextY:nextY cur:cur])
    {
        return NO;
    }
    
    //如果将棋棋子放在对手的巢穴里，定胜为真
    if ([self inOpponentDen:cur x:nextX y:nextY])
    {
//        this.win = true;
    }
    
    // 如果没有敌人的棋子活着，就把胜利定为真。
    for (int i = 0; i < self.chessPieceModels.count; i++)
    {
        if ([cur team] != [self.chessPieceModels[i] team] && [self.chessPieceModels[i] alive]) {
            break;
        }
//        if (i == self.chessPieceModels.length - 1) this.win = true;
    }
    // 移动块并从当前位置移除
    NSValue *value = self.frames[nextX][nextY];
    self.selectedPiece.frame = value.CGRectValue;
    [self.selectedPiece setSelected:NO];
    self.selectedPiece.model.col_index = nextY;
    self.selectedPiece.model.row_index = nextX;
    return YES;
}



@end
