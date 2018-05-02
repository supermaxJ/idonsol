//
//  Card.m
//  idonsol
//
//  Created by zemadr on 17/2/14.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import "Card.h"

@interface Card ()
@property (nonatomic, copy) NSString *str;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, copy) NSString *valueStr;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *cardImage;
@property (nonatomic, assign) CardType cardType;
@end

@implementation Card

- (id)initWithCardStr:(NSString *)str {
    self = [super init];
    if (self) {
        _str = str;
        [self handleStr];
    }
    return self;
}

- (void)handleStr {
    NSString *flag = [self.str substringFromIndex:self.str.length-1];
    if ([flag isEqualToString:@"D"]) {
        _cardType = CardTypeDiamonds;
    } else if ([flag isEqualToString:@"S"]) {
        _cardType = CardTypeSpades;
    } else if ([flag isEqualToString:@"C"]) {
        _cardType = CardTypeClubs;
    } else if ([flag isEqualToString:@"H"]) {
        _cardType = CardTypeHearts;
    } else {
        _cardType = CardTypeJoker;
    }
    
    [self initialValues:flag];
}

- (void)initialValues:(NSString *)flag {
    NSString *subStr = [self.str substringToIndex:self.str.length-1];
    NSInteger value = [subStr integerValue];
    _value = value;
    _cardImage = [NSString stringWithFormat:@"card_%@_%ld", flag, value];
    
    if (self.cardType == CardTypeDiamonds) {
        _color = [UIColor redColor];
        _symbol = @"♦︎";
    } else if (self.cardType == CardTypeHearts) {
        _color = [UIColor redColor];
        _symbol = @"♥︎";
    } else if (self.cardType == CardTypeSpades) {
        _color = [UIColor blackColor];
        _symbol = @"♠︎";
    } else if (self.cardType == CardTypeClubs) {
        _color = [UIColor blackColor];
        _symbol = @"♣︎";
    } else {
        if (_value == 1) {      // 黑王
            _color = [UIColor blackColor];
            _symbol = @"♚";
        } else {                // 红王
            _color = [UIColor redColor];
            _symbol = @"♛";
        }
        _value = 21;
    }
    
    if (_value == 17) {
        _valueStr = @"A(17)";
    } else if (_value <= 10) {
        _valueStr = [NSString stringWithFormat:@"%ld", _value];
    } else if (_value == 11) {
        _valueStr = @"J(11)";
    } else if (_value == 13) {
        _valueStr = @"Q(13)";
    } else if (_value == 15) {
        _valueStr = @"K(15)";
    } else if (_value == 21) {
        _valueStr = @"Joker(21)";
    }
    
    if (self.cardType == CardTypeHearts ||
        self.cardType == CardTypeDiamonds) {
        if (_value == 17) {
            _valueStr = @"A(11)";
            _value = 11;
        } else if (_value <= 10) {
            _valueStr = [NSString stringWithFormat:@"%ld", _value];
        } else if (_value == 11) {
            _valueStr = @"J(11)";
            _value = 11;
        } else if (_value == 13) {
            _valueStr = @"Q(11)";
            _value = 11;
        } else if (_value == 15) {
            _valueStr = @"K(11)";
            _value = 11;
        }
    }
}

@end
