//
//  YoutubeViewController.h
//  YouTubeApp
//
//  Created by Anthony Ma on 26/7/2016.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTPlayerView;

@interface YoutubeViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
