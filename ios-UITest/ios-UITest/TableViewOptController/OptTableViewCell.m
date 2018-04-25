//
//  OptTableViewCell.m
//  ios-UITest
//
//  Created by Long Yang on 2018/4/16.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "OptTableViewCell.h"
#import "UIView+Additions.h"
#import "UIScreen+Additions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "NSString+Additions.h"
#import "FitConsts.h"

@implementation OptTableViewCell {
    UIImageView *postBGView;
    UIButton *avatarView;
    UIImageView *cornerImage;
    UIView *topLine;
    UILabel *label;
    UILabel *detailLabel;
    UIScrollView *mulitPhotoScrollView;
    BOOL drawed;
    NSInteger drawColorFlag;
    CGRect commentsRect;
    CGRect repostsRect;
    
    UILabel *nameLabel;
    UILabel *dateTimeLabel;
    UILabel *commentsLabel;
    UIImageView *commentsImageView;
    UILabel *repostsLabel;
    UIImageView *repostsImageView;
    UILabel *pointsLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;  //设置剪裁边界，超出cell的内容剪裁掉
        postBGView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView insertSubview:postBGView atIndex:0];  //在最底层插入postBGView，subviews是栈结构
        [self initlLayout];
    }
    return self;
}

- (void)initlLayout {
    avatarView = [UIButton buttonWithType:UIButtonTypeCustom];//[[VVeboAvatarView alloc] initWithFrame:avatarRect];
    avatarView.frame = CGRectMake(SIZE_GAP_LEFT, SIZE_GAP_TOP, SIZE_AVATAR, SIZE_AVATAR);
    avatarView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    avatarView.hidden = NO;
    avatarView.tag = NSIntegerMax;
    avatarView.clipsToBounds = YES;
    [self.contentView addSubview:avatarView];
    
    cornerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE_AVATAR+5, SIZE_AVATAR+5)];
    cornerImage.center = avatarView.center;
    cornerImage.image = [UIImage imageNamed:@"corner_circle@2x.png"];
    cornerImage.tag = NSIntegerMax;
    [self.contentView addSubview:cornerImage];
    
    topLine = [[UIView alloc] initWithFrame:CGRectZero];
    topLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    topLine.tag = NSIntegerMax;
    [self.contentView addSubview:topLine];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:nameLabel];
    
    dateTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:dateTimeLabel];
    
    mulitPhotoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    mulitPhotoScrollView.scrollsToTop = NO;
    mulitPhotoScrollView.showsHorizontalScrollIndicator = NO;
    mulitPhotoScrollView.showsVerticalScrollIndicator = NO;
    mulitPhotoScrollView.tag = NSIntegerMax;
    mulitPhotoScrollView.hidden = YES;
    [self.contentView addSubview:mulitPhotoScrollView];
    
    int h2 = SIZE_GAP_IMG+SIZE_IMAGE;
    for (NSInteger i=0; i<9; i++) {
        int g = SIZE_GAP_IMG;
        int width = SIZE_IMAGE;
        float x = SIZE_GAP_LEFT+(g+width)*(i%3);
        float y = i/3*h2;
        UIImageView *thumb1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, y+2, SIZE_IMAGE, SIZE_IMAGE)];
        thumb1.tag = i+1;
        [mulitPhotoScrollView addSubview:thumb1];
    }
    
    commentsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:commentsLabel];
    
    commentsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    commentsImageView.image = [UIImage imageNamed:@"t_comments.png"];
    [self.contentView addSubview:commentsImageView];
    
    repostsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:repostsLabel];
    
    repostsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    repostsImageView.image = [UIImage imageNamed:@"t_repost.png"];
    [self.contentView addSubview:repostsImageView];
    
    pointsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    pointsLabel.font = FontWithSize(11);
    pointsLabel.text = @"•••";
    [self.contentView addSubview:pointsLabel];
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    label.backgroundColor = self.backgroundColor;
    label.numberOfLines = -1;
    [self.contentView addSubview:label];
    
    detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    detailLabel.font = FontWithSize(SIZE_FONT_SUBCONTENT);
    detailLabel.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];;
    detailLabel.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    detailLabel.numberOfLines = -1;
    [self.contentView addSubview:detailLabel];
}

- (void)drawWithData:(NSDictionary *)data {
    CGRect rect = [data[@"frame"] CGRectValue];
    self.frame = rect;
    
    topLine.frame = CGRectMake(0, self.height-.5, UIScreen.screenWidth, .5);
    
    [avatarView setBackgroundImage:nil forState:UIControlStateNormal];
    if ([data valueForKey:@"avatarUrl"]) {
        NSURL *url = [NSURL URLWithString:[data valueForKey:@"avatarUrl"]];
        [avatarView sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil options:SDWebImageLowPriority];
    }
    
    float leftX = SIZE_GAP_LEFT+SIZE_AVATAR+SIZE_GAP_BIG;

    float y = (SIZE_AVATAR-(SIZE_FONT_NAME+SIZE_FONT_SUBTITLE+6))/2-2+SIZE_GAP_TOP+SIZE_GAP_SMALL-5;
    nameLabel.frame = CGRectMake(leftX, y, SIZE_FONT_NAME*[data[@"name"] length], SIZE_FONT_NAME);
    nameLabel.text = data[@"name"];
    nameLabel.font = FontWithSize(SIZE_FONT_NAME);
    
    y += SIZE_FONT_NAME + 5;
    NSString *from = [NSString stringWithFormat:@"%@  %@", data[@"time"], data[@"from"]];
    dateTimeLabel.frame = CGRectMake(leftX, y, SIZE_FONT_SUBTITLE*from.length, SIZE_FONT_SUBTITLE);
    dateTimeLabel.text = from;
    dateTimeLabel.font = FontWithSize(SIZE_FONT_SUBTITLE);
    
//    if ([data valueForKey:@"subData"]) {
//        CGRect subFrame = [data[@"subData"][@"frame"] CGRectValue];
//        UIView *view = [[UIView alloc] initWithFrame:subFrame];
//        view.backgroundColor = BG_GRAY_COLOR;
//        [self addSubview:view];
//    }
    
    CGRect countRect = CGRectMake(0, rect.size.height-30, [UIScreen screenWidth], 30);
    float x = [UIScreen screenWidth]-SIZE_GAP_LEFT-10;
    if ([data valueForKey:@"comments"]) {
        NSString *comments = data[@"comments"];
        CGSize size = [comments sizeWithConstrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) fromFont:FontWithSize(SIZE_FONT_SUBTITLE) lineSpace:5];
        x -= size.width;
        commentsLabel.frame = CGRectMake(x, 8+countRect.origin.y, size.width, size.height);
        commentsLabel.font = FontWithSize(SIZE_FONT_SUBTITLE);
        commentsLabel.text = comments;
        commentsImageView.frame = CGRectMake(x-5, 10.5+countRect.origin.y, 10, 9);
        commentsRect = CGRectMake(x-5, 11+countRect.origin.y, 10, 9);
        x -= 30;
    }
    
    if ([data valueForKey:@"reposts"]) {
        NSString *reposts = data[@"reposts"];
        CGSize size = [reposts sizeWithConstrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) fromFont:FontWithSize(SIZE_FONT_SUBTITLE) lineSpace:5];
        repostsLabel.frame = CGRectMake(x, 8+countRect.origin.y, size.width, size.height);
        repostsLabel.font = FontWithSize(SIZE_FONT_SUBTITLE);
        repostsLabel.text = reposts;
        repostsImageView.frame = CGRectMake(x-5, 11+countRect.origin.y, 10, 9);
        repostsRect = CGRectMake(x-5, self.height-50, commentsRect.origin.x-x, 50);
        x -= 30;
    }
    
    pointsLabel.frame = CGRectMake(SIZE_GAP_LEFT, 8+countRect.origin.y, 3 * 11, 11);
    
    if ([data valueForKey:@"textRect"] && [data valueForKey:@"text"]) {
        label.frame = [data[@"textRect"] CGRectValue];
        label.text = data[@"text"];
    }
    
    if ([data valueForKey:@"subData"]) {
        detailLabel.frame = [[data valueForKey:@"subData"][@"textRect"] CGRectValue];
        [detailLabel setText:[data valueForKey:@"subData"][@"text"]];
    }
    
    [self loadThumbWithData:data];
    
}

- (void)loadThumbWithData:(NSDictionary *)data {
    float y = 0;
    NSArray *urls;
    if ([data valueForKey:@"subData"]) {
        CGRect subPostRect = [data[@"subData"][@"textRect"] CGRectValue];
        y = subPostRect.origin.y + subPostRect.size.height+SIZE_GAP_BIG;
        urls = [data valueForKey:@"subData"][@"pic_urls"];
    } else {
        CGRect postRect = [data[@"textRect"] CGRectValue];
        y = postRect.origin.y+postRect.size.height+SIZE_GAP_BIG;
        urls = data[@"pic_urls"];
    }
    
    if (urls.count>0) {
        mulitPhotoScrollView.hidden = NO;
        mulitPhotoScrollView.y = y;
        mulitPhotoScrollView.frame = CGRectMake(0, y, [UIScreen screenWidth], SIZE_GAP_IMG+((SIZE_GAP_IMG+SIZE_IMAGE)*(urls.count)));
        for (NSInteger i=0; i<9; i++) {
            UIImageView *thumbView = (UIImageView *)[mulitPhotoScrollView viewWithTag:i+1];
            thumbView.contentMode = UIViewContentModeScaleAspectFill;
            thumbView.backgroundColor = [UIColor lightGrayColor];
            thumbView.clipsToBounds = YES;
            if (i<urls.count) {
                thumbView.frame = CGRectMake(SIZE_GAP_LEFT+(SIZE_GAP_IMG+SIZE_IMAGE)*i, .5, SIZE_IMAGE, SIZE_IMAGE);
                thumbView.hidden = NO;
                NSDictionary *url = urls[i];
                [thumbView sd_setImageWithURL:[NSURL URLWithString:url[@"thumbnail_pic"]]];
            } else {
                thumbView.hidden = YES;
            }
        }
        float cw = SIZE_GAP_LEFT*2+(SIZE_GAP_IMG+SIZE_IMAGE)*urls.count;
        if (cw<self.width) {
            cw = self.width;
        }
        if (mulitPhotoScrollView.contentSize.width!=cw) {
            mulitPhotoScrollView.contentSize = CGSizeMake(cw, 0);
        }
    }
}

@end
