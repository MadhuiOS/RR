//
//  FilterFindPlayerViewController.h
//  SportsSub
//
//  Created by Home on 9/2/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"


@interface FilterFindPlayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (weak, nonatomic) IBOutlet UILabel *lowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperLabel;

- (IBAction)labelSliderChanged:(NMRangeSlider*)sender;


@end
