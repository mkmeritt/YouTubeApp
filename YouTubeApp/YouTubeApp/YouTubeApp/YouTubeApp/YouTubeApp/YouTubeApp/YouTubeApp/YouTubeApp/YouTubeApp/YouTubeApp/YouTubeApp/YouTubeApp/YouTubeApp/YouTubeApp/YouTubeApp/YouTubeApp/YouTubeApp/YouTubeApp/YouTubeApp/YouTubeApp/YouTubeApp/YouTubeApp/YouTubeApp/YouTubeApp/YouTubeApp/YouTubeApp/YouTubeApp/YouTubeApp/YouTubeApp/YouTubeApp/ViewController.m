//
//  ViewController.m
//  YouTubeApp
//
//  Created by Mark Meritt on 2016-07-25.
//  Copyright © 2016 Apptist. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

MoodsDataSource* moods;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    moods = [[MoodsDataSource alloc] init];
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
    
}
@end
