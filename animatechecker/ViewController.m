//
//  ViewController.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)NSArray *frames;
@property(nonatomic, strong)UIImageView *game_board_view;
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
    self.frames = [self createFrames:self.game_board_view.bounds];
}


- (NSArray *)createFrames:(CGRect)bounds
{
    
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGFloat item_width = bounds.size.width / (COL * 1.0);
    CGFloat item_height = bounds.size.height / (ROW* 1.0);
    for (int col = 0; col < COL; col++)
    {
        for (int row = 0; row < ROW; row++)
        {
            CGFloat x = item_width * col;
            CGFloat y = item_height * row;
            CGRect frame = CGRectMake(x, y, item_width, item_height);
            NSValue *value = [NSValue valueWithCGRect:frame];
            [frames addObject:value];
            UIView *view = [[UIView alloc] initWithFrame:frame];
            UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
            view.backgroundColor = randomColor;
            [self.game_board_view addSubview:view];
        }
    }
    return [frames copy];
}

- (void)reset
{
    // clear board
    for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board[0].length; j++) {
            board[i][j] = null;
        }
    }
    board[0][0] = pieces[BLACK_LION];
    pieces[BLACK_LION].setX(0);
    pieces[BLACK_LION].setY(0);
    board[6][0] = pieces[BLACK_TIGER];
    pieces[BLACK_TIGER].setX(6);
    pieces[BLACK_TIGER].setY(0);
    board[1][1] = pieces[BLACK_DOG];
    pieces[BLACK_DOG].setX(1);
    pieces[BLACK_DOG].setY(1);
    board[5][1] = pieces[BLACK_CAT];
    pieces[BLACK_CAT].setX(5);
    pieces[BLACK_CAT].setY(1);
    board[0][2] = pieces[BLACK_MOUSE];
    pieces[BLACK_MOUSE].setX(0);
    pieces[BLACK_MOUSE].setY(2);
    board[2][2] = pieces[BLACK_LEOPARD];
    pieces[BLACK_LEOPARD].setX(2);
    pieces[BLACK_LEOPARD].setY(2);
    board[4][2] = pieces[BLACK_WOLF];
    pieces[BLACK_WOLF].setX(4);
    pieces[BLACK_WOLF].setY(2);
    board[6][2] = pieces[BLACK_ELEPHANT];
    pieces[BLACK_ELEPHANT].setX(6);
    pieces[BLACK_ELEPHANT].setY(2);
    board[0][6] = pieces[RED_ELEPHANT];
    pieces[RED_ELEPHANT].setX(0);
    pieces[RED_ELEPHANT].setY(6);
    board[2][6] = pieces[RED_WOLF];
    pieces[RED_WOLF].setX(2);
    pieces[RED_WOLF].setY(6);
    board[4][6] = pieces[RED_LEOPARD];
    pieces[RED_LEOPARD].setX(4);
    pieces[RED_LEOPARD].setY(6);
    board[6][6] = pieces[RED_MOUSE];
    pieces[RED_MOUSE].setX(6);
    pieces[RED_MOUSE].setY(6);
    board[1][7] = pieces[RED_CAT];
    pieces[RED_CAT].setX(1);
    pieces[RED_CAT].setY(7);
    board[5][7] = pieces[RED_DOG];
    pieces[RED_DOG].setX(5);
    pieces[RED_DOG].setY(7);
    board[0][8] = pieces[RED_TIGER];
    pieces[RED_TIGER].setX(0);
    pieces[RED_TIGER].setY(8);
    board[6][8] = pieces[RED_LION];
    pieces[RED_LION].setX(6);
    pieces[RED_LION].setY(8);
    for (int i = 0; i < pieces.length; i++) {
        pieces[i].revive();
    }
}


@end
