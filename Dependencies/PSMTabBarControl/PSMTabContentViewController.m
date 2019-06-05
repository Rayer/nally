//
//  PSMTabContentViewController.m
//  PSMTabBarControl
//
//  Created by Jean-Philippe Couture on 2012-08-01.
//  Copyright 2012 Jean-Philippe Couture. All rights reserved.
//

#import "PSMTabContentViewController.h"

@implementation PSMTabContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tabViewItem:(NSTabViewItem *)tabViewItem {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabViewItem = tabViewItem;
    }
    return self;
}

@end