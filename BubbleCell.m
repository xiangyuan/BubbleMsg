//
//  BubbleCell.m
//  BubbleMsg
//
//  Created by li yajie on 12/18/12.
//  Copyright (c) 2012 com.coamee. All rights reserved.
//

#import "BubbleCell.h"



@implementation BubbleCell
{
    
}
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initViews];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self setUserInteractionEnabled:YES];
    }
    return self;
}


-(void) initViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    _bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _postTimeLbl = [[UILabel alloc] initWithFrame:CGRectZero];
//    _headImageView = [[UIImageView alloc] initWithImage:nil];
    _nameLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    //message
    _messageLbl.backgroundColor = [UIColor clearColor];
    _messageLbl.font = [UIFont systemFontOfSize:kMessageTextSize];
    _messageLbl.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLbl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    _messageLbl.numberOfLines = 0;
    
    /*name label*/
    _nameLbl.font = [UIFont systemFontOfSize:14.f];
    _nameLbl.textColor = [UIColor blueColor];
    _nameLbl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    _nameLbl.backgroundColor = [UIColor clearColor];
    /*time Label*/
    _postTimeLbl.font = [UIFont systemFontOfSize:12.f];
    _postTimeLbl.textColor = [UIColor lightGrayColor];
    _postTimeLbl.backgroundColor = [UIColor clearColor];
     _postTimeLbl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    /*message view*/
    messageView = [[UIView alloc] initWithFrame:CGRectZero];
    messageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    [messageView addSubview:_bubbleImageView];
    [messageView addSubview:_messageLbl];
    
    [_bubbleImageView release];
    [_messageLbl release];
    
    [self.contentView addSubview:_postTimeLbl];
    [_postTimeLbl release];
    [self.contentView addSubview:messageView];
    [messageView release];
    [self.contentView addSubview:_nameLbl];
    [_nameLbl release];
//    [self.contentView addSubview:_headImageView];    
    /*add gesture*/
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [recognizer setMinimumPressDuration:1.0f];
    [self addGestureRecognizer:recognizer];
    [recognizer release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- layout the views
-(void)layoutSubviews {
    CGSize msgSize = [self caculateTextSize:_messageLbl.text];
    CGSize nameSize = [_nameLbl.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(120.f, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    if (_msgType == kFromMsg) {// other from
        _nameLbl.frame = CGRectMake(5.f, 5.f, nameSize.width + 40.f, nameSize.height);
        _nameLbl.textAlignment = UITextAlignmentRight;
        _postTimeLbl.frame = CGRectMake(6.f,_nameLbl.frame.origin.y + nameSize.height, _nameLbl.frame.size.width, 26.f);
        _postTimeLbl.textAlignment = UITextAlignmentCenter;
        messageView.frame = CGRectMake(_postTimeLbl.frame.size.width + _postTimeLbl.frame.origin.x, 5.f,msgSize.width + 30.f, msgSize.height + 15.f);
        _bubbleImageView.frame = CGRectMake(1.f, 1.f,msgSize.width + 30.f,msgSize.height + 15.f);
        _messageLbl.frame = CGRectMake(15.f, 5.f, msgSize.width + 15.f, msgSize.height + 8.f);
        
//        if (self.isSelected) {
//            
//        }
        [_bubbleImageView setImage:[[UIImage imageNamed:@"chat_inmsg.png"] stretchableImageWithLeftCapWidth:20.f topCapHeight:34.f]];
    } else if (_msgType == kToMsg) {//me send
        _nameLbl.textAlignment = UITextAlignmentLeft;
        _nameLbl.frame = CGRectMake(self.frame.size.width - nameSize.width - 40.f, 5.f, nameSize.width + 40.f, nameSize.height);
        _postTimeLbl.frame = CGRectMake(_nameLbl.frame.origin.x,_nameLbl.frame.origin.y + nameSize.height, _nameLbl.frame.size.width, 26.f);
        _postTimeLbl.textAlignment = UITextAlignmentCenter;
        
        
        messageView.frame = CGRectMake(self.frame.size.width - nameSize.width - msgSize.width - 70.f, 3.f, msgSize.width, msgSize.height);
        _bubbleImageView.frame = CGRectMake(1.f, 2.f, msgSize.width + 30.f, msgSize.height + 20.f);
        _messageLbl.frame = CGRectMake(8.f, 5.f, msgSize.width + 15.f, msgSize.height + 8.f);
        
        [_bubbleImageView setImage:[[UIImage imageNamed:@"chat_tomsg_active.png"] stretchableImageWithLeftCapWidth:13.f topCapHeight:34.f]];
    }
    // picture
    
}

#pragma mark --delegate handle
-(void) handleLongPress:(UILongPressGestureRecognizer*)gesture {
    int tag = gesture.view.tag - 200;
    if ([delegate respondsToSelector:@selector(cellItemLongPressed:)]) {
        [delegate cellItemLongPressed:tag];
    }
}

#pragma mark -- private method implments
-(CGFloat)textWidth {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 190.f;
    } else {
        return 400.f;
    }
}
// get the message text size
+(CGSize)messageSize:(NSString*) originText {
    CGFloat width = 0.f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        width = 190.f;
    } else {
        width = 400.f;
    }
    CGSize size = [originText sizeWithFont:[UIFont systemFontOfSize:kMessageTextSize] constrainedToSize:CGSizeMake(width, FLT_MAX)lineBreakMode:UILineBreakModeWordWrap];
    return size;
}
//cal the text height
-(CGSize)caculateTextSize:(NSString *)text {
   CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:kMessageTextSize] constrainedToSize:CGSizeMake([self textWidth], FLT_MAX)lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

- (void)dealloc
{
    [_nameLbl release];
    [_postTimeLbl release];
    [_messageLbl release];
    [_bubbleImageView release];
    [messageView release];
    [super dealloc];
}

@end
