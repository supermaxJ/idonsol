//
//  CardView.h
//  idonsol
//
//  Created by zemadr on 17/2/14.
//  Copyright © 2017年 snakejay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView
@property (nonatomic, strong) Card *card;

@property (nonatomic, copy) void (^didClick)(CardView *cardView);
@end
