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
@property (strong, nonatomic) NSString* selectedMood;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;

-(void)prepareGestureRecoginzers;
-(void)prepareSwipeGestureRecognizers;
-(void)handleTapGesture:(UITapGestureRecognizer*)sender;

@end
