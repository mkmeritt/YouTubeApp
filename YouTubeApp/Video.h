//
//  Video.h
//  YouTubeApp
//
//  Created by Anthony Ma on 26/7/2016.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Video : NSObject

@property (nonatomic, strong) UIImage *videoThumbnail;
@property (nonatomic, strong) NSString *videoID;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *comments;

@end
