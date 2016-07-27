//
//  YoutubeViewController.m
//  YouTubeApp
//
//  Created by Anthony Ma on 26/7/2016.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "YoutubeViewController.h"
#import "ViewController.h"  
#import "AppDelegate.h"
#import "YTPlayerView.h"
<<<<<<< HEAD
#import "Video.h"
=======
#import "YouTubeLayout.h"
#import "VideoCell.h"
>>>>>>> 6003ba20da88162dcad4cc0eb95a4df71b1c8995

@interface YoutubeViewController () <YTPlayerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableDictionary *videoDictionary;

@property (nonatomic, strong) NSMutableArray *commentsArray;

@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, strong) YouTubeLayout *youTubeLayout;

@property (nonatomic, strong) Video *video;

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation YoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    
//    [appDelegate.managedObjectContext executeRequest:appDelegate.persistentStoreCoordinator error:(NSError * _Nullable __autoreleasing * _Nullable)];
    
    //set player view parameters
    self.playerView.delegate = self;
    self.playerView.backgroundColor = [UIColor blackColor];
    
    //api request
//    [self apiFetch];
    [self apiCommentsFetch];
    
<<<<<<< HEAD
    //set and load video to player
    self.video = [self createVideo];
    [self videoID:self.video andID:@""];
    [self.playerView loadWithVideoId:@"PQ4y2MNvJK0"];
=======
    self.youTubeLayout = [[YouTubeLayout alloc] init];
>>>>>>> 6003ba20da88162dcad4cc0eb95a4df71b1c8995
    
    [self.collectionView setCollectionViewLayout:self.youTubeLayout animated:YES];
    
    NSLog(@"Mood is: %@", self.selectedMood);
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
//    [self.playerView loadVideoById:@"UCE_M8A5yxnLfW0KghEeajjw" startSeconds:1 suggestedQuality:4];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

<<<<<<< HEAD
#pragma mark - AppDelegate Properties Access



#pragma mark - Video Initiation 

- (Video *)createVideo {
    Video *video = [[Video alloc] init];
    return video;
}

- (void)videoID:(Video *)video andID:(NSString *)videoID {
    video.videoID = videoID;
=======
/////TOUCH EVENTS
-(void)prepareGestureRecoginzers{
    [self prepareSwipeGestureRecognizers];
}

-(void)handleTapGesture:(UITapGestureRecognizer *)sender{
    
}

-(void)prepareSwipeGestureRecognizers{
    
}

-(void)swiped:(UISwipeGestureRecognizer*) recognizer{
    
>>>>>>> 6003ba20da88162dcad4cc0eb95a4df71b1c8995
}

#pragma mark - API Initiation

//- (NSURL *)URLforComment {
//    NSString *commentAPI = @"https://www.googleapis.com/youtube/v3/commentThread?
//}

- (NSURL *)URLforCommentThread {
    NSString *apiKey = @"AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4";
    NSString *urlOne = @"https://www.googleapis.com/youtube/v3/commentThread?";
    NSString *part = @"part=videoID&textFormat&key=";
    NSString *appended = [NSString stringWithFormat:@"%@%@%@", urlOne, part, apiKey];
    NSURL *URL = [NSURL URLWithString:appended];
    return URL;
}

- (NSURL *)URLforVideo {
    NSString *apiKey = @"AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4";
    NSString *urlOne = @"https://www.googleapis.com/youtube/v3/videos?";
    NSString *part = @"part=contentDetails&chart=mostPopular&key=";
    NSString *appended = [NSString stringWithFormat:@"%@%@%@", urlOne, part, apiKey];
    NSURL *URL = [NSURL URLWithString:appended];
    return URL;
}
 
#pragma mark - API Request

- (void)apiCommentsFetch {
    
    NSString *urlString = @"https://www.googleapis.com/youtube/v3/search?&part=snippet&q=happy&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&pageToken=CAUQAA";
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    NSLog(@"Request Done");
    
    if (!error) {
        
        NSError *jsonError;
        
        NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (!jsonError) {
            
//            NSLog(@"Data: %@", data);
            [self logJSONData:videosListing];
            
            for (NSDictionary *properties in videosListing[@"items"]) {
                if ([properties isKindOfClass:[NSDictionary class]]) {
                    Video *video = [[Video alloc] init];
                    NSString *imageString = properties[@"snippet"][@"thumbnails"][@"default"][@"url"];
                    NSURL *urlImage = [NSURL URLWithString:imageString];
                    NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                    video.videoThumbnail = [UIImage imageWithData:imageData];
                    video.videoID = properties[@"id"][@"videoId"];
                    [tempArray addObject:video];
                }
            }
        }
        else {
            NSLog(@"NO");
        }
        
        self.videoArray = tempArray;
        
            dispatch_async(dispatch_get_main_queue(), ^{
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
//                [self.collectionView reloadData];
            });
    }
    else {
        NSLog(@"Request error: %@", error.localizedDescription);
    }
    
}];

[dataTask resume];

}

<<<<<<< HEAD
- (NSString *)searchParameters {
    return @"";
}

- (void)searchString {
    ViewController *viewController = [[ViewController alloc] init];
    NSString *searchParameters = @"Joyful, ";
}

- (void)logJSONData:(NSDictionary *)list {
    NSLog(@"JSON: %@", list);
}

#pragma mark - API results 
=======
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{  //NUMBER OF ITEMS FETCHED
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    
    return cell;
    
}

>>>>>>> 6003ba20da88162dcad4cc0eb95a4df71b1c8995

- (void)videoIDs {
    
}

@end
