//
//  ChessPieceModel.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ChessPieceModel.h"

@implementation ChessPieceModel

- (void)capture
{
    self.alive = false;
}

- (void)revive
{
    self.alive = true;
}

- (NSString *)animate_name
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
