//
//  MJSecondDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sports.h"

@protocol PopupDelegate;


@interface POPUPViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) id <PopupDelegate>delegate;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSString *selectionType;
@property (nonatomic, strong) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *selectionArray;

@end



@protocol PopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(POPUPViewController*)secondDetailViewController;
- (void)DoneButtonClicked:(POPUPViewController *)aSecondDetailViewController selectedArray:(NSArray*)array;

@end