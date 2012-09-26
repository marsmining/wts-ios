//
//  MainViewController.h
//  WTS
//
//  Created by foo on 9/20/12.
//  Copyright (c) 2012 Ockham Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainDao.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong) MainDao *mainDao;

@end
