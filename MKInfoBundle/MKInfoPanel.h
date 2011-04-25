//
//  MKInfoPanel.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef enum MKInfoPanelType_
{    
    MKInfoPanelTypeInfo,
    MKInfoPanelTypeError
} MKInfoPanelType;

@interface MKInfoPanel : UIView {
    
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    
    UIImageView *_thumbImage;
    UIImageView *_backgroundGradient;
}

@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) IBOutlet UILabel *detailLabel;
@property (nonatomic, retain) IBOutlet UIImageView *thumbImage;
@property (nonatomic, assign) IBOutlet UIImageView *backgroundGradient;

+(void) showPanelInView:(UIView*) view type:(MKInfoPanelType) type title:(NSString*) title subtitle:(NSString*) subtitle hideAfter:(NSTimeInterval) interval;

@end
