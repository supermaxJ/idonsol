//
//  BoardC.m
//  idonsol
//
//  Created by zemadr on 17/2/14.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import "BoardC.h"
#import "Board.h"
#import "Card.h"
#import "CardView.h"

@interface BoardC () <UIAlertViewDelegate>
@property (nonatomic, strong) Board *board;
@property (weak, nonatomic) IBOutlet UILabel *ibLifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibShieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibDepthLabel;
@property (weak, nonatomic) IBOutlet UIView *ibRightView;
@end

@implementation BoardC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
}

- (void)initial {
    [self refreshValues];
    [self fetchCards];
}

- (void)refreshValues {
    self.ibLifeLabel.text = [NSString stringWithFormat:@"%ld", self.board.life];
    self.ibShieldLabel.text = [NSString stringWithFormat:@"%ld(%ld)",
                               self.board.shield,
                               self.board.shieldDurable];
    self.ibDepthLabel.text = [NSString stringWithFormat:@"%ld", self.board.roomCount];
    
    [self refreshStatus];
}

- (void)fetchCards {
    NSArray *cards = [self.board fetchCards];
    [self refreshCards:cards];
}

- (void)refreshCards:(NSArray *)cards {
    for (int i=0; i<4; i++) {
        CardView *cardView = [self.ibRightView viewWithTag:100 + i];
        cardView.didClick = ^(CardView *cardV) {
            [self didClickWithCard:cardV];
        };
        
        if (i+1 > cards.count) {
            [cardView setCard:nil];
        } else {
            Card *card = cards[i];
            [cardView setCard:card];
        }
    }
}

- (void)didClickWithCard:(CardView *)cardV {
    if (!cardV.card) {
        return;
    }
    
    [self.board removeCard:cardV.card];
    [self refreshValues];
}

- (void)nextTurn {
    [self fetchCards];
}

- (IBAction)ibaPASS:(id)sender {
    if ([self.board pass]) {
        [self nextTurn];
    }
}

- (IBAction)ibaESCAPE:(id)sender {
    if ([self.board escape]) {
        [self nextTurn];
    }
}

- (void)refreshStatus {
    if (self.board.life > 0 && self.board.roomCount >= 54) {
        [self win];
    } else if (self.board.life <= 0) {
        [self die];
    }
}

- (void)win {
    [[[UIAlertView alloc] initWithTitle:@"消息" message:@"你赢了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重玩", nil]
     show];
}

- (void)die {
    [[[UIAlertView alloc] initWithTitle:@"消息" message:@"你输了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重玩", nil]
     show];
}

- (void)reset {
    [self.board reset];
    [self initial];
}

#pragma mark - uialertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self reset];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - getter & setter
- (Board *)board {
    if (!_board) {
        _board = [[Board alloc] init];
    }
    return _board;
}
@end
