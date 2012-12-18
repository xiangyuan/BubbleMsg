//
//  ViewController.m
//  BubbleMsg
//
//  Created by li yajie on 12/18/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "ViewController.h"

#import "BubbleCell.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_messages;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    
    BubbleCell * cell = (BubbleCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BubbleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize messageSize = [BubbleCell messageSize:[_messages objectAtIndex:indexPath.row]];
    return messageSize.height + 40.0f;
}

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    BubbleCell* ccell = (BubbleCell*)cell;
    
    if (indexPath.row % 2 == 0) {
        ccell.msgType = kFromMsg;
        ccell.nameLbl.text = @"向远:";
    } else {
        ccell.msgType = kToMsg;
        ccell.nameLbl.text = @":向远";
    }
    
    
    ccell.messageLbl.text = [_messages objectAtIndex:indexPath.row];
    ccell.postTimeLbl.text = @"2012-08-29";
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view load.");
	// Do any additional setup after loading the view, typically from a nib.
    _messages = [[NSArray alloc] initWithObjects:
                 @"Hello, 大家好.",
                 @"I'm great, how are you?",
                 @"I'm fine, thanks. Up for dinner tonight?",
                 @"Glad to hear. No sorry, I have to work.",
                 @"Oh that sucks. A pitty, well then - have a nice day..Oh that sucks. A pitty, well then - have a nice day..Oh that sucks. A pitty, well then - have a nice day..Oh that sucks. A pitty, well then - have a nice day.."
                 @"Thanks! You too. Cuu soon.Oh that sucks. A pitty, well then - have a nice day..",
                 nil];
    _mTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mTableView release];
    [super dealloc];
}
@end
