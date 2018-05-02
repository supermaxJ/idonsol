//
//  Board.h
//  idonsol
//
//  Created by zemadr on 17/2/13.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Board : NSObject
@property (nonatomic, assign, readonly) BOOL canEscape;     // 是否可以跳过
@property (nonatomic, assign, readonly) BOOL canPass;       // 是否可以下一关
@property (nonatomic, assign, readonly) NSInteger life;
@property (nonatomic, assign, readonly) NSInteger shieldDurable;        // 盾牌耐久
@property (nonatomic, assign, readonly) NSInteger shield;               // 盾牌值
@property (nonatomic, assign, readonly) NSInteger roomCount;            // 探索的房间数


@property (nonatomic, strong, readonly) NSMutableArray *boardCards;     // 台面上的牌

- (NSArray *)fetchCards;
- (void)backCardsToBoard:(NSArray *)cards;
- (void)removeCard:(Card *)card;

- (BOOL)escape;
- (BOOL)pass;

- (void)reset;

@end
