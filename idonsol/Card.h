//
//  Card.h
//  idonsol
//
//  Created by zemadr on 17/2/14.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CardType) {
    CardTypeDiamonds,                   // Diamonds 方片, spades 黑桃, clubs 梅花, hearts 红心
    CardTypeSpades,
    CardTypeClubs,
    CardTypeHearts,
    CardTypeJoker
};

@interface Card : NSObject
- (id)initWithCardStr:(NSString *)str;

@property (nonatomic, copy, readonly) NSString *str;
@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, assign, readonly) NSInteger value;
@property (nonatomic, copy, readonly) NSString *valueStr;
@property (nonatomic, copy, readonly) NSString *symbol;
@property (nonatomic, copy, readonly) NSString *cardImage;
@property (nonatomic, assign, readonly) CardType cardType;
@end
