//
//  YoutubeViewController.m
//  YouTubeApp
//
//  Created by Anthony Ma on 26/7/2016.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "YoutubeViewController.h"
#import "YTPlayerView.h"

@interface YoutubeViewController () <YTPlayerViewDelegate>

@property (nonatomic, strong) NSMutableArray *videoArray;

@end

@implementation YoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerView.delegate = self;
    
    self.playerView.backgroundColor = [UIColor blackColor];
    
    [self apiFetch];
    
//    [self.playerView loadVideoById:@"UCE_M8A5yxnLfW0KghEeajjw" startSeconds:1 suggestedQuality:4];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - API Initiation

- (NSURL *)URL {
    return [NSURL URLWithString:@"https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=Apple&key=AIzaSyCK8NV2bi5TPJ3-wa60C5vEqQMGEx8CQP4"];
}

#pragma mark - API Request

- (void)apiFetch {

NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[self URL]];
NSURLSession *sharedSession = [NSURLSession sharedSession];

NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    
    NSLog(@"Request Done");
    
    if (!error) {
        
        NSError *jsonError;
        
        NSDictionary *videosListing = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!jsonError) {
            
            NSLog(@"Data: %@", data);
            
            NSLog(@"JSON: %@", videosListing);
            
        }
        else {
                    NSLog(@"NO");
        }
            
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



@end
