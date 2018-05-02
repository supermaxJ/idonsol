//
//  Board.m
//  idonsol
//
//  Created by zemadr on 17/2/13.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import "Board.h"

@interface Board ()
@property (nonatomic, strong) NSMutableArray *cards;

@property (nonatomic, assign) BOOL last_escaped;        // 上一场是否escape
@property (nonatomic, assign) BOOL last_used_add_position;      // 上一次是否使用生命，如使用，此次加生命无效，浪费一张生命牌；否则life+=生命
@end

@implementation Board

- (id)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial {
    // Diamonds 方片, spades 黑桃, clubs 梅花, hearts 红心
    
    _cards = @[@"17D",@"2D",@"3D",@"4D",@"5D",@"6D",@"7D",@"8D",@"9D",@"10D",@"11D",@"13D", @"15D",
               @"17S",@"2S",@"3S",@"4S",@"5S",@"6S",@"7S",@"8S",@"9S",@"10S",@"11S",@"13S", @"15S",
               @"17C",@"2C",@"3C",@"4C",@"5C",@"6C",@"7C",@"8C",@"9C",@"10C",@"11C",@"13C", @"15C",
               @"17H",@"2H",@"3H",@"4H",@"5H",@"6H",@"7H",@"8H",@"9H",@"10H",@"11H",@"13H", @"15H",
               @"1J",@"2J"].mutableCopy;
    
    _life = 21;
    _shield = 0;
    _shieldDurable = 0;
    _roomCount = 0;
    
    _boardCards = @[].mutableCopy;
    
    _last_escaped = NO;
    _last_used_add_position = NO;
    
    [self shuffle];
}

- (void)shuffle {
    for (int i = 0; i < [_cards count]; i++ ) {
        int random = arc4random() % [_cards count];
        NSString * temp1 = _cards[i];
        _cards[i] = _cards[random];
        _cards[random] = temp1;
    }
}

- (NSArray *)fetchCards {
    NSInteger remainCount = _cards.count;
    if (remainCount > 4) {
        remainCount = 4;
    }
    
    NSMutableArray *result = @[].mutableCopy;
    NSMutableArray *tempStr = @[].mutableCopy;
    for (int i=0; i<remainCount; i++) {
        NSString *cardStr = _cards[i];
        [tempStr addObject:cardStr];
        Card *card = [[Card alloc] initWithCardStr:cardStr];
        [result addObject:card];
    }
    
    [_cards removeObjectsInArray:tempStr];
    
    [result removeObjectsInArray:_cards];
    
    // 放入台面
    [self clearBoardCards];
    [_boardCards addObjectsFromArray:result];
    
    return result.copy;
}

- (void)backCardsToBoard:(NSArray *)cards {
    for (int i=0; i<cards.count; i++) {
        Card *card = cards[i];
        [_cards addObject:card.str];
    }
    
    [self clearBoardCards];
    [self shuffle];
}

// Diamonds 方片, spades 黑桃, clubs 梅花, hearts 红心
- (void)removeCard:(Card *)card {
    if (card.cardType == CardTypeSpades ||
        card.cardType == CardTypeClubs) {
        [self makeDamage:card.value];
    } else if (card.cardType == CardTypeDiamonds) {
        [self makeShield:card.value];
    } else if (card.cardType == CardTypeHearts) {
        [self addPosition:card.value];
    } else if (card.cardType == CardTypeJoker) {
        [self makeDamage:card.value];
    }
    
    _roomCount += 1;
    
    [_cards removeObject:card];
    [_boardCards removeObject:card];
}

- (void)clearBoardCards {
    [_boardCards removeAllObjects];
}

- (void)makeDamage:(NSInteger)damage {
    if (self.shield > 0) {
        if (_shieldDurable > damage) {          // 耐久度大于伤害
            _shieldDurable -= damage;
            
            if (self.shield < damage) {         // 防御小于伤害
                _life -= (damage - self.shield);
            }
        } else {                                // 耐久度小于伤害（盾牌损坏，伤害全由生命承担）
            _shieldDurable = 0;
            _shield = 0;
            _life -= damage;
        }
    } else {                                    // 无盾牌，伤害全由生命承担
        _life -= damage;
    }
}

- (void)addPosition:(NSInteger)position {
    if (!self.last_used_add_position) {
        _life += position;
        if (_life > 21) {
            _life = 21;
        }
    }
}

- (void)makeShield:(NSInteger)shield {
    _shield = shield;
    _shieldDurable = 25;
}

- (void)passNewGame {
    self.last_escaped = NO;
    self.last_used_add_position = NO;
    [self backCardsToBoard:_boardCards];
}

- (void)escapeNewGame {
    self.last_used_add_position = NO;
    [self backCardsToBoard:_boardCards];
}

- (BOOL)escape {
    if (self.last_escaped) {
        return NO;
    }
    
    self.last_escaped = YES;
    [self escapeNewGame];
    return YES;
}

- (BOOL)pass {
    if ([self checkIfExistMonster]) {
        return NO;
    }
    
    [self passNewGame];
    return YES;
}

- (BOOL)checkIfExistMonster {
    for (Card *card in self.boardCards) {
        if (card.cardType == CardTypeSpades ||
            card.cardType == CardTypeClubs ||
            card.cardType == CardTypeJoker) {
            return YES;
        }
    }
    
    return NO;
}

- (void)reset {
    [self initial];
}
@end
