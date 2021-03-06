//
//  GameController.m
//  ThreeLow v2
//
//  Created by Jamie on 2018-08-01.
//  Copyright © 2018 Jamie. All rights reserved.
//

#import "GameController.h"
#import "Dice.h"

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _holdDieSet = [[NSMutableSet alloc] init];
        _allRollsArray = [[NSMutableArray alloc] init];
        for (int i=0; i<5; i++) {
            Dice *die = [[Dice alloc] init]; // inits an instance of die
            [_allRollsArray addObject:die]; //loads instances of dies to be rolled into array
        }
    }
    return self;
}

- (void)holdDie:(int)index{
    Dice *holder = [self.allRollsArray objectAtIndex:index-1]; //loads die at index from array and loading into a Dice object
    if ([self.holdDieSet containsObject:holder]){
        [self.holdDieSet removeObject:holder]; 
    }
    else{
    [self.holdDieSet addObject:holder]; //adds Dice object to held die set
    }
}

- (NSString *)description{
    NSMutableString *yourHand = [[NSMutableString alloc] initWithString:@"Here are the results :"];
    int score = 0;
    for (int i=0; i<5; i++) {
        Dice *die = [self.allRollsArray objectAtIndex:i]; //load objects from array to a Dice instance
        score += die.currentValue;
        if ([self.holdDieSet containsObject:die]){
            [yourHand appendFormat:@"\n     [%@]",die.description];
        }
          else
        [yourHand appendFormat:@"\n     %@",die.description]; //
    }
    [yourHand appendFormat:@"\nScore %i",score];
    return yourHand;
}

- (void)rollDie{
    for (int i=0; i<5; i++) {
        Dice *die = [self.allRollsArray objectAtIndex:i];
        if (![self.holdDieSet containsObject:die])
            [die roll];
    }
}
- (void)resetDice{
    [self.holdDieSet removeAllObjects];
}
@end
