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
#import "Video.h"
#import "YouTubeLayout.h"
#import "VideoCell.h"

@interface YoutubeViewController () <YTPlayerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableDictionary *videoDictionary;

@property (nonatomic, strong) YouTubeLayout *youTubeLayout;

@property (nonatomic, strong) Video *video;

@property (nonatomic, strong) NSString *nextPageToken;

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *baseHappyAPI;
@property (nonatomic, strong) NSString *baseSadAPI;
@property (nonatomic, strong) NSString *baseAdventurousAPI;
@property (nonatomic, strong) NSString *baseFunnyAPI;
@property (nonatomic, strong) NSString *baseSeriousAPI;
@property (nonatomic, strong) NSString *baseSillyAPI;
@property (nonatomic, strong) NSString *baseAngryAPI;

@property (nonatomic, strong) NSArray *arrayOfVideos;
@property (nonatomic, strong) NSMutableArray *videoArray;

@end

@implementation YoutubeViewController


//UIImage* videoImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseHappyAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=PkC0uQMGVUY&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseSadAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=BTJH3CP23DI&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseAdventurousAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=-HH_uRgwEVY&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseFunnyAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=BTJH3CP23DI&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseSeriousAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=KrsSM0hCESI&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseSillyAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=1qgOCtciprY&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    self.baseAngryAPI = @"https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=_mWtWz_aGyk&type=video&videoEmbeddable=true&order=relevance&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4&maxResults=50&pageToken=";
    
    //set player view parameters
    self.playerView.delegate = self;
    self.playerView.backgroundColor = [UIColor blackColor];

    //set and load video to player
    self.video = [self createVideo];
    [self videoID:self.video andID:@""];
    [self.playerView loadWithVideoId:@"M8wNsBwEGJ4"];
    
    //api request
//    [self apiFetch];
  //  [self apiCommentsFetch];
    
    //set and load video to player
    self.video = [self createVideo];
    [self videoID:self.video andID:@""];
    [self.playerView loadWithVideoId:@"PQ4y2MNvJK0"];
    self.youTubeLayout = [[YouTubeLayout alloc] init];
    
   // [self.collectionView setCollectionViewLayout:self.youTubeLayout animated:YES];
    
    NSLog(@"Mood is: %@", self.selectedMood);
    
    if ([self.selectedMood isEqualToString:@"happy"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiHappy];
    }
         
    if ([self.selectedMood isEqualToString:@"sad"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiSad];
    }
    
    if ([self.selectedMood isEqualToString:@"adventourous"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiAdventurous];
    }
    
    if ([self.selectedMood isEqualToString:@"funny"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiFunny];
    }
    
    if ([self.selectedMood isEqualToString:@"serious"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiSerious];
    }
    
    if ([self.selectedMood isEqualToString:@"silly"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiSilly];
    }
    
    if ([self.selectedMood isEqualToString:@"angry"]) {
        self.videoArray = [[NSMutableArray alloc] init];
        [self apiAngry];
    }
    
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

#pragma mark - AppDelegate Properties Access



#pragma mark - Video Initiation 

- (Video *)createVideo {
    Video *video = [[Video alloc] init];
    return video;
}

- (void)videoID:(Video *)video andID:(NSString *)videoID {
    video.videoID = videoID;
}
/////TOUCH EVENTS
-(void)prepareGestureRecoginzers {
    [self prepareSwipeGestureRecognizers];
}

-(void)handleTapGesture:(UITapGestureRecognizer *)sender{
    
}

-(void)prepareSwipeGestureRecognizers{
    
}

-(void)swiped:(UISwipeGestureRecognizer*) recognizer{

}
 
#pragma mark - API Happy

- (void)apiHappy {

    if (!self.urlString) {
        self.urlString = self.baseHappyAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseHappyAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiHappy];
                }
                else {
                    NSLog(@"done");
                }
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
                [self.collectionView reloadData];
            });
        }
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

#pragma mark - API Sad

- (void)apiSad {
    
    if (!self.urlString) {
        self.urlString = self.baseSadAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseSadAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiSad];
                }
                else {
                    NSLog(@"done");
                }
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
                [self.collectionView reloadData];
            });
        }
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

#pragma mark - API Adventurous

- (void)apiAdventurous {
    
    
    if (!self.urlString) {
        self.urlString = self.baseAdventurousAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseAdventurousAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiAdventurous];
                }
                else {
                    NSLog(@"done");
                }
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
                [self.collectionView reloadData];

            });
        }
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

#pragma mark - API Funny

- (void)apiFunny {
    
    
    if (!self.urlString) {
        self.urlString = self.baseFunnyAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseFunnyAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiFunny];
                }
                else {
                    NSLog(@"done");
                }
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

#pragma mark - API Serious

- (void)apiSerious {
    
    if (!self.urlString) {
        self.urlString = self.baseSeriousAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseSeriousAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiSerious];
                }
                else {
                    NSLog(@"done");
                }
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

#pragma mark - API Silly

- (void)apiSilly {
    
    if (!self.urlString) {
        self.urlString = self.baseSeriousAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseSeriousAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiSerious];
                }
                else {
                    NSLog(@"done");
                }
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
                [self.collectionView reloadData];
            });
        }
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

#pragma mark - Angry API

- (void)apiAngry {
    
    if (!self.urlString) {
        self.urlString = self.baseSeriousAPI;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSString *pageTokenString;
            NSMutableArray *tempArray = [NSMutableArray array];
            if (!jsonError) {
                if ([videosListing[@"nextPageToken"] isKindOfClass:[NSString class]]) {
                    pageTokenString = [NSString stringWithFormat:@"%@", videosListing[@"nextPageToken"]];
                    self.nextPageToken = pageTokenString;
                }
                
                for (NSDictionary *properties in videosListing[@"items"]) {
                    if ([properties isKindOfClass:[NSDictionary class]]) {
                        Video *video = [[Video alloc] init];
                        NSString *imageString = properties[@"snippet"][@"thumbnails"][@"high"][@"url"];
                        NSURL *urlImage = [NSURL URLWithString:imageString];
                        NSData *imageData = [NSData dataWithContentsOfURL:urlImage];
                        video.videoThumbnail = [UIImage imageWithData:imageData];
                        video.videoID = properties[@"id"][@"videoId"];
                        [tempArray addObject:video];
                        self.arrayOfVideos = tempArray;
                    }
                }
            }
            [self.videoArray addObjectsFromArray:self.arrayOfVideos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.videoArray.count < 250) {
                    self.urlString = [NSString stringWithFormat:@"%@%@", self.baseSeriousAPI, self.nextPageToken];
                    NSLog(@"%@", self.urlString);
                    [self apiSerious];
                }
                else {
                    NSLog(@"done");
                }
                self.title = [NSString stringWithFormat:@"Your Moody Videos"];
                [self.collectionView reloadData];
            });
        }
        else {
            NSLog(@"Request error: %@", error.localizedDescription);
        }
    }];
    [dataTask resume];
}

#pragma mark - API results 

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{  //NUMBER OF ITEMS FETCHED
    return self.videoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    
    Video* video = [self.videoArray objectAtIndex:indexPath.item];
    
    cell.imageView.image = video.videoThumbnail;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videoArray objectAtIndex:indexPath.item];
    
    [self.playerView loadWithVideoId:video.videoID];
    
}

- (void)videoIDs {
    
}

@end
