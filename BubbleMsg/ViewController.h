//
//  ViewController.h
//  BubbleMsg
//
//  Created by li yajie on 12/18/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *mTableView;

@end
