//
//  BubbleCell.h
//  BubbleMsg
//
//  Created by li yajie on 12/18/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMessageTextSize 14.0f
#define kMessageWidth 200.f
#define kTagBase 200

typedef enum {
    kFromMsg = 0,
    kToMsg = 1,
} MsgType;

@class BubbleCell;

@protocol BubbleCellDelegate <NSObject>

@optional
-(void) cellItemLongPressed:(NSInteger) index;


@end

@interface BubbleCell : UITableViewCell
{
    UIView * messageView;
}

@property(nonatomic,retain) UIImageView * headImageView;

@property(nonatomic,retain) UILabel * nameLbl;

@property(nonatomic,retain) UILabel *postTimeLbl;

@property(nonatomic,retain) UILabel *messageLbl;

@property(nonatomic,retain) UIImageView *bubbleImageView;


@property(nonatomic,assign) MsgType msgType;

@property(nonatomic,unsafe_unretained) id<BubbleCellDelegate> delegate;


+(CGSize)messageSize:(NSString*) originText;

-(CGSize) caculateTextSize:(NSString*) text;

-(CGFloat) textWidth;


@end
