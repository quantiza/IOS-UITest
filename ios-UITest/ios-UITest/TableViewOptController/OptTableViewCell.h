//
//  OptTableViewCell.h
//  ios-UITest
//
//  Created by Long Yang on 2018/4/16.
//  Copyright © 2018年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIZE_GAP_LEFT 15
#define SIZE_GAP_TOP 13
#define SIZE_AVATAR 40
#define SIZE_GAP_BIG 10
#define SIZE_GAP_IMG 5
#define SIZE_GAP_SMALL 5
#define SIZE_IMAGE 80
#define SIZE_FONT 17
#define SIZE_FONT_NAME (SIZE_FONT-3)
#define SIZE_FONT_SUBTITLE (SIZE_FONT-8)
#define FontWithSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define SIZE_FONT_CONTENT 17
#define SIZE_FONT_SUBCONTENT (SIZE_FONT_CONTENT-1)

@interface OptTableViewCell : UITableViewCell

- (void)drawWithData:(NSDictionary *)data;
//@property (nonatomic, weak) NSDictionary *data;

@end
