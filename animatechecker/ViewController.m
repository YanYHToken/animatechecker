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

@interface ViewController ()<UIAlertViewDelegate>
@property(nonatomic, strong)NSMutableArray *all_chess;
@property(nonatomic, strong)UIImageView *game_board_view;
@property(nonatomic, assign)CGFloat item_width;
@property(nonatomic, assign)CGFloat item_height;
@property(nonatomic, assign)Team play_team;
@property(nonatomic, assign)int selected_x_index;
@property(nonatomic, assign)int selected_y_index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
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
    [self reset];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"重新开始" forState:UIControlStateNormal];
    [button setTitle:@"重新开始" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
    button.frame = CGRectMake((self.view.frame.size.width-100)/2, 30, 100, 30);
    [button addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
}


- (void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.game_board_view];
    NSLog(@"handleSingleTap ! pointx:%f,y:%f",point.x,point.y);
    int x_index = point.x/self.item_width;
    int y_index = point.y/self.item_height;
    int border = 10;
    if((self.item_height * y_index + border < point.y) &&
       (self.item_width * x_index + border < point.x) &&
       (self.item_width * (x_index + 1) - border > point.x)  &&
       (self.item_height * (y_index + 1) - border > point.y))
    {
        PieceModel *cur = self.all_chess[x_index][y_index];
        if(self.selected_x_index == -1 && self.selected_y_index == -1)
        {
            if(self.play_team == [cur team] && [cur alive])
            {
                NSLog(@"selection in x_index = %i y_index = %i", x_index, y_index);
                self.selected_x_index = x_index;
                self.selected_y_index = y_index;
                [cur selected:YES];
            }
        }
        else
        {
            if(self.selected_x_index != x_index || self.selected_y_index != y_index)
            {
                PieceModel *old_target = self.all_chess[self.selected_x_index][self.selected_y_index];
                NSLog(@"movePiece to x_index = %i y_index = %i", x_index, y_index);
                if([old_target team] == [cur team] && [cur alive])
                {
                    NSLog(@"selection in x_index = %i y_index = %i", x_index, y_index);
                    self.selected_x_index = x_index;
                    self.selected_y_index = y_index;
                    [cur selected:YES];
                    [old_target selected:NO];
                }
                else
                {
                    BOOL move = [self movePiece:self.selected_x_index curY:self.selected_y_index nextX:x_index nextY:y_index];
                    if(move)
                    {
                        NSLog(@"move this square success!!!!!!");
                        self.selected_x_index = -1;
                        self.selected_y_index = -1;
                        if(self.play_team == Black_Team)self.play_team = Red_Team;
                        else if(self.play_team == Red_Team)self.play_team = Black_Team;
                    }
                    else
                    {
                        NSLog(@"can not move this square!!!!!!");
                    }
                }
            }
            else
            {
                NSLog(@"the same selection");
            }
        }
    }
}

- (NSMutableArray *)chessInBoard:(CGRect)bounds
{
    NSMutableArray *all_values = [[NSMutableArray alloc] init];
    self.item_width = bounds.size.width / (X_NUMS * 1.0);
    self.item_height = bounds.size.height / (Y_NUMS * 1.0);
    for (int x_index = 0; x_index < X_NUMS; x_index++)
    {
        NSMutableArray *x_values = [NSMutableArray array];
        for (int y_index = 0; y_index < Y_NUMS; y_index++)
        {
            CGFloat x = self.item_width * x_index;
            CGFloat y = self.item_height * y_index;
            CGRect frame = CGRectMake(x, y, self.item_width, self.item_height);
            PieceModel *model = [[PieceModel alloc] init];
            model.frame = frame;
            model.y_index = y_index;
            model.x_index = x_index;
            model.team = Unknow_Team;
            [x_values addObject:model];
        }
        [all_values addObject:x_values];
    }
    return all_values;
}



- (void)createPieces
{
    [self configPieceDatas:@"black_lion" animal:[AnimateDatas LION] chess_piece_index:BLACK_LION x_index:0 y_index:0];
    [self configPieceDatas:@"black_tiger" animal:[AnimateDatas TIGER] chess_piece_index:BLACK_TIGER x_index:6 y_index:0];
//    [self configPieceDatas:@"black_dog" animal:[AnimateDatas DOG] chess_piece_index:BLACK_DOG x_index:1 y_index:1];
//    [self configPieceDatas:@"black_cat" animal:[AnimateDatas CAT] chess_piece_index:BLACK_CAT x_index:5 y_index:1];
//    [self configPieceDatas:@"black_mouse" animal:[AnimateDatas MOUSE] chess_piece_index:BLACK_MOUSE x_index:0 y_index:2];
//    [self configPieceDatas:@"black_leopard" animal:[AnimateDatas LEOPARD] chess_piece_index:BLACK_LEOPARD x_index:2 y_index:2];
//    [self configPieceDatas:@"black_wolf" animal:[AnimateDatas WOLF] chess_piece_index:BLACK_WOLF x_index:4 y_index:2];
//    [self configPieceDatas:@"black_elephant" animal:[AnimateDatas ELEPHANT] chess_piece_index:BLACK_ELEPHANT x_index:6 y_index:2];
    
    
    [self configPieceDatas:@"red_lion" animal:[AnimateDatas LION] chess_piece_index:RED_LION x_index:6 y_index:8];
    [self configPieceDatas:@"red_tiger" animal:[AnimateDatas TIGER] chess_piece_index:RED_TIGER x_index:0 y_index:8];
    [self configPieceDatas:@"red_dog" animal:[AnimateDatas DOG] chess_piece_index:RED_DOG x_index:5 y_index:7];
    [self configPieceDatas:@"red_cat" animal:[AnimateDatas CAT] chess_piece_index:RED_CAT x_index:1 y_index:7];
    [self configPieceDatas:@"red_mouse" animal:[AnimateDatas MOUSE] chess_piece_index:RED_MOUSE x_index:6 y_index:6];
    [self configPieceDatas:@"red_leopard" animal:[AnimateDatas LEOPARD] chess_piece_index:RED_LEOPARD x_index:4 y_index:6];
    [self configPieceDatas:@"red_wolf" animal:[AnimateDatas WOLF] chess_piece_index:RED_WOLF x_index:2 y_index:6];
    [self configPieceDatas:@"red_elephant" animal:[AnimateDatas ELEPHANT] chess_piece_index:RED_ELEPHANT x_index:0 y_index:6];
    
}

- (void)configPieceDatas:(NSString *)img_name
                       animal:(NSString *)animal
            chess_piece_index:(int)chess_piece_index
                      x_index:(int)x_index
                      y_index:(int)y_index
{
    PieceModel *model;
    model = self.all_chess[x_index][y_index];
    [model modelWith:img_name animal:animal chess_piece_index:chess_piece_index x_index:x_index y_index:y_index];
    [model revive];
    CGRect frame = model.frame;
    model.frame = frame;
    if(chess_piece_index <= RED_ELEPHANT)
    {
        model.team = Red_Team;
    }
    else
    {
        model.team = Black_Team;
    }
    [self.game_board_view addSubview:model.chessView];
}




/**
 *给定一个棋子的当前位置和它的位置
 *目标，捕获片段返回真实，如果捕获是有效的。返回错误
 *如果捕获无效，则什么也不做。
 * @param curX x coordinate of chess piece
 * @param curY y coordinate of chess piece
 * @param nextX x coordinate of target piece
 * @param nextY y coordinate of target piece
 * @param cur current chess piece
 * @return true if piece was captured, false if capture is not valid
 */
- (BOOL)capture:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY cur:(PieceModel *) cur
{
    NSString *a = [cur animal];
    PieceModel *target = self.all_chess[nextX][nextY];
    if([target alive])
    {
        NSString *b = [target animal];
        //如果目标棋子等级较高，则返回假。
        //除非cur是鼠标或除非目标处于陷阱
        if ([cur chess_piece_index] - [target chess_piece_index] < 0
            && ![a isEqualToString:[AnimateDatas MOUSE]]
            && ![self inTrap:target x:nextX y:nextY])
        {
            return NO;
        }
        //鼠标只能捕捉大象和老鼠
        //注意鼠标不能捕获另一个鼠标，除非它们是
        //或在河上，或在陆地上
        if (([a isEqualToString:[AnimateDatas MOUSE]]
             && ![b isEqualToString:[AnimateDatas ELEPHANT]]
             && ![b isEqualToString:[AnimateDatas MOUSE]])
            || ([self inRiver:curX y:curY] != [self inRiver:nextX y:nextY])){
            return NO;
        }
        // 大象捉不到老鼠
        if ([a isEqualToString:[AnimateDatas ELEPHANT]]
            && [b isEqualToString:[AnimateDatas MOUSE]]) {
            return NO;
        }
    }
    // 捕捉目标
    [target capture];
    return YES;
}

/**
 *检查下一个位置是否可由棋子访问
 *注意不考虑该位置是否被占用。
 *另一棋子
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
    PieceModel *cur = self.all_chess[curX][curY];
    if ([self inOwnDen:cur x:nextX y:nextY]) {
        return NO;
    }
    return YES;
}


/** 棋子是不是一步到位 */
- (BOOL)oneStepAway:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    BOOL one = ((abs(nextX - curX) == 1 && nextY == curY) || (abs(nextY - curY) == 1 && nextX == curX));
    NSLog(@"if one = YES one step awawy. one = %@", one == YES ? @"YES" : @"NO");
    return one;
}

/** 如果区域在河中，则返回真。取其x，y坐标*/
- (BOOL)inRiver:(int)x y:(int)y
{
    BOOL rive = (((x > 0 && x < 3) || (x > 3 && x < 6)) && (y > 2 && y < 6));
    NSLog(@"if rive = YES square in rive. rive = %@", rive == YES ? @"YES" : @"NO");
    return rive;
}

/** 如果棋子在对手的巢穴中，给出一个棋子和目标X和Y坐标，则返回真。*/
- (BOOL)inOpponentDen:(PieceModel *)cp x:(int)x y:(int)y
{
    BOOL inOtherDen = ([cp team] == Red_Team && x == 3 && y == 0) || ([cp team] == Black_Team && x == 3 && y == 8);
    NSLog(@"if inOtherDen = YES in Opponent den. inOtherDen = %@", inOtherDen == YES ? @"YES" : @"NO");
    return inOtherDen;
}

/**如果棋子将在自己的巢穴中，给出一个棋子和目标X和Y坐标，则返回真。*/
- (BOOL)inOwnDen:(PieceModel *) cp x:(int)x y:(int)y
{
    BOOL inOwnDen = ([cp team] == Black_Team && x == 3 && y == 0) || ([cp team] == Red_Team && x == 3 && y == 8);
    NSLog(@"if inOwnDen = YES in self den. inOwnDen = %@", inOwnDen == YES ? @"YES" : @"NO");
    return inOwnDen;
}

/** 如果棋子在陷阱中，给出一个棋子，它的当前x和y坐标返回true*/
- (BOOL)inTrap:(PieceModel *) cp x:(int)x y:(int)y
{
    BOOL trap;
    if([cp team] == Red_Team)
    {
        NSLog(@"in red trap");
        trap = (x == 2 && y == 0) || (x == 3 && y == 1) || (x == 4 && y == 0);
    }
    else if([cp team] == Black_Team)
    {
        NSLog(@"in black trap");
        trap = (x == 2 && y == 8) || (x == 3 && y == 7) || (x == 4 && y == 8);
    }
    else
    {
        NSLog(@"not in trap");
        trap = NO;
    }
    return trap;
}

/**
 * 如果狮子和老虎能跳过河，除非他们没有老鼠，否则就要返回真实。
 */
- (BOOL)jumpException:(NSString *)a curX:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    // 如果动物不是狮子或老虎，则返回假
    if (![a isEqualToString:[AnimateDatas LION]] && ![a isEqualToString:[AnimateDatas TIGER]])
    {
        NSLog(@"如果动物不是狮子或老虎，不能跳河");
        return NO;
    }
    //检查狮子/老虎是否在河的左边或右边
    //和打算跳转到另一边。
    if ((curX == 0 || curX == 3 || curX == 6) && (curY > 2 && curY < 6))
    {
        // 如果预期的位置横跨河流返回真实
        if (abs(nextX - curX) == 3 && (nextY == curY))
        {
            // 检查河里是否有一只老鼠挡住了跳水
            for (int i = 1; i < 3; i++)
            {
                int sign = (nextX - curX) % 2;
                PieceModel *value = self.all_chess[curX + sign * i][curY];
                if ([value alive])
                {
                    NSLog(@"有老鼠，不能跳河");
                    return NO;
                }
            }
            NSLog(@"能跳河");
            return YES;
        }
    }
    // 检查狮子/老虎是否在河的上方或下方，意欲跳到
    //对方一边
    if ((curY == 2 || curY == 6) && (curX == 1 || curX == 2 || curX == 4 || curX == 5)) {
        if (abs(nextY - curY) == 4 && (nextX == curX))
        {
            // 检查河里是否有一只老鼠挡住了跳水
            for (int i = 1; i < 4; i++)
            {
                int sign = (nextY - curY) % 3;
                PieceModel *value = self.all_chess[curX][curY + sign * i];
                if ([value alive])
                {
                    NSLog(@"有老鼠，不能跳河");
                    return NO;
                }
            }
            NSLog(@"能跳河");
            return YES;
        }
    }
    // else return false
    return NO;
}

/**
 *该方法采用当前位置和预期位置。
 *如果移动是合法的，它相应地移动棋子并返回。
 *是真的。它也更新赢得变量，如果游戏赢得了这一举动。
 *否则它什么也不做，并返回false。
 * @param curX current x coordinate
 * @param curY current y coordinate
 * @param nextX intended x coordinate
 * @param nextY intended y coordinate
 * @return BOOL
 */
- (BOOL)movePiece:(int)curX curY:(int)curY nextX:(int)nextX nextY:(int)nextY
{
    PieceModel *cur = self.all_chess[curX][curY];
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
    // 如果没有敌人的棋子活着，就把胜利定为真。
    int black_alive_nums = [self alives:Black_Team];
    int red_alive_nums = [self alives:Red_Team];
    if([self inOpponentDen:cur x:nextX y:nextY] ||
       ((black_alive_nums == 0 && [cur team] == Red_Team) || (red_alive_nums == 0 && [cur team] == Black_Team)))
    {
        [self winTeam:[cur team]];
    }
    // 移动块并从当前位置移除
    PieceModel *next_value = self.all_chess[nextX][nextY];
    [cur updatePosition:next_value];
    self.all_chess[curX][curY] = next_value;
    self.all_chess[nextX][nextY] = cur;
    [cur selected:NO];
    return YES;
}

- (void)winTeam:(Team)team
{
    NSString *message = @"恭喜黑队获胜！！！！！！";
    if(team == Red_Team)
    {
        message = @"恭喜红队获胜！！！！！！";
    }
    [self showMessage:message];
}
- (int)alives:(Team)team
{
    int alive_nums = 0;
    for (int i = 0; i < self.all_chess.count; i++)
    {
        NSMutableArray *models = self.all_chess[i];
        for (PieceModel *model in models)
        {
            if ([model team] == team && [model alive])
            {
                alive_nums++;
            }
        }
    }
    return alive_nums;
}

- (void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self reset];
}

- (void)reset
{
    NSArray *subviews = [self.game_board_view subviews];
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    [self.all_chess removeAllObjects];
    self.all_chess = nil;
    self.all_chess = [self chessInBoard:self.game_board_view.bounds];
    self.selected_x_index = -1;
    self.selected_y_index = -1;
    self.play_team = Red_Team;
    [self createPieces];
}

@end
