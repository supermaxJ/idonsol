//
//  CardView.m
//  idonsol
//
//  Created by zemadr on 17/2/14.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import "CardView.h"

@interface CardView ()
@property (weak, nonatomic) IBOutlet UILabel *ibTopLeftValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibBottomRightValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibSymbolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ibBg;

@end

@implementation CardView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                initWithTarget:self
                                action:@selector(click:)]];
}

- (void)setCard:(Card *)card {
    _card = card;
    [self refreshView];
}

- (void)refreshView {
    if (_card) {
        self.ibTopLeftValueLabel.text = @"0";
        self.ibBottomRightValueLabel.text = @"0";
        self.ibSymbolLabel.text = @"A";
        self.ibBg.hidden = YES;
    }
    
    self.ibTopLeftValueLabel.text = _card.valueStr;
    self.ibBottomRightValueLabel.text = _card.valueStr;
    
    self.ibSymbolLabel.text = _card.symbol;
    
    self.ibTopLeftValueLabel.textColor =
    self.ibBottomRightValueLabel.textColor =
    self.ibSymbolLabel.textColor = _card.color;
}

- (void)click:(UITapGestureRecognizer *)gesture {
    self.ibBg.hidden = NO;
    if (self.didClick) {
        self.didClick(self);
    }
}

@end
