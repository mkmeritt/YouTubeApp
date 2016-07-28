//
//  ViewController.m
//  YouTubeApp
//
//  Created by Mark Meritt on 2016-07-25.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString* moodString;
@property (nonatomic, assign) BOOL btnPressed;

@end

@implementation ViewController

MoodsDataSource* moods;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    moods = [[MoodsDataSource alloc] init];
    
     self.moodString = @"happy"; //default
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
   return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return moods.moods.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [moods.moods objectAtIndex:row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.moodString = [moods.moods objectAtIndex:row];
    
    if([self.moodString isEqualToString:@"happy"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube"];
    }
    
    if([self.moodString isEqualToString:@"sad"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube blue"];
    }
    
    if([self.moodString isEqualToString:@"adventerous"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube green"];
    }
    
    if([self.moodString isEqualToString:@"funny"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube orange"];
    }
    
    if([self.moodString isEqualToString:@"serious"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube pink"];
    }
    
    if([self.moodString isEqualToString:@"silly"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube yellow"];
    }
    
    if([self.moodString isEqualToString:@"angry"]){
        self.youTubeImg.image = [UIImage imageNamed:@"youtube magenta"];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([[segue identifier] isEqualToString:@"showResults"]) {
        
        if(self.btnPressed) {
            
            YoutubeViewController *controller = segue.destinationViewController;
            controller.selectedMood = self.moodString;
        }
        
    }

}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = (UILabel*)view;
    
    if(!label) {
        
        label = [[UILabel alloc] init];
        
        label.font = [UIFont fontWithName:@"SourceSansPro-Semibold"    size:40];
        
        label.textAlignment = NSTextAlignmentCenter;
        
    }
    
    [label setText:[moods.moods objectAtIndex:row]];
    
    return label;
    
}

- (IBAction)btnPressed:(id)sender {
    if(!self.btnPressed) {
        self.btnPressed = YES;
        
        
    }
}
@end
