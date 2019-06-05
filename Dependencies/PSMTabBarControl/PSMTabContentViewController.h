//
//  PSMTabContentViewController.h
//  PSMTabBarControl
//
//  Created by Jean-Philippe Couture on 2012-08-01.
//  Copyright 2012 Jean-Philippe Couture. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PSMTabContentViewController : NSViewController

@property (strong) NSTabViewItem *tabViewItem;

@property (nonatomic, assign) BOOL isProcessing;
@property (nonatomic, strong) NSImage *icon;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) NSInteger objectCount;
@property (nonatomic, assign) BOOL isEdited;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tabViewItem:(NSTabViewItem *)tabViewItem;

@end
