//
//  MoodsDataSource.m
//  YouTubeApp
//
//  Created by Mark Meritt on 2016-07-25.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "MoodsDataSource.h"

@implementation MoodsDataSource

-(instancetype)init{
    
    if(self = [super init]){
    _moods = @[@"happy", @"sad", @"adventerous", @"funny", @"serious", @"silly", @"angry"];
    }
    
    return self;
}

@end
