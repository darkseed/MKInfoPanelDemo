//
//  MKInfoPanel.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above
//  Read my blog post at http://mk.sg/8e on how to use this code

//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	While I'm ok with modifications to this source code, 
//	if you are re-publishing after editing, please retain the above copyright notices

#import "MKInfoPanel.h"
#import <QuartzCore/QuartzCore.h>

// Private Methods
// this should be added before implementation block 

@interface MKInfoPanel (PrivateMethods)
@property (nonatomic, assign) MKInfoPanelType type;
+ (MKInfoPanel*) infoPanel;
@end


@implementation MKInfoPanel
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
@synthesize thumbImage = _thumbImage;
@synthesize backgroundGradient = _backgroundGradient;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setType:(MKInfoPanelType)type
{
    if(type == MKInfoPanelTypeError)
    {
        self.backgroundGradient.image = [[UIImage imageNamed:@"Red"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.detailLabel.font = [UIFont fontWithName:@"Helvetica Neue" 
                                                size:14];
        self.thumbImage.image = [UIImage imageNamed:@"Warning"];
        self.detailLabel.textColor = RGBA(255, 140, 140, 0.6);

    }
    else if(type == MKInfoPanelTypeInfo)
    {
        self.backgroundGradient.image = [[UIImage imageNamed:@"Blue"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        self.thumbImage.image = [UIImage imageNamed:@"Tick"];   
        self.detailLabel.textColor = RGBA(210, 210, 235, 1.0);
    }
        
}
+(MKInfoPanel*) infoPanel
{
    MKInfoPanel *panel =  (MKInfoPanel*) [[[UINib nibWithNibName:@"MKInfoPanel" bundle:nil] 
                                           instantiateWithOwner:self options:nil] objectAtIndex:0];

    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromBottom;
	[panel.layer addAnimation:transition forKey:nil];
    
    return panel;
}

+(void) showPanelInView:(UIView*) view type:(MKInfoPanelType) type title:(NSString*) title subtitle:(NSString*) subtitle hideAfter:(NSTimeInterval) interval
{
    MKInfoPanel *panel = [MKInfoPanel infoPanel];
    [panel setType:type];
    panel.titleLabel.text = title;
    if(subtitle)
    {
        panel.detailLabel.text = subtitle;
    }
    else
    {
        panel.detailLabel.hidden = YES;
        panel.frame = CGRectMake(0, 0, 320, 50);
        panel.thumbImage.frame = CGRectMake(15, 5, 35, 35);
        panel.titleLabel.frame = CGRectMake(57, 12, 240, 21);
        
    }
    
    [view addSubview:panel];
    [panel performSelector:@selector(hidePanel) withObject:view afterDelay:interval];
}

-(void) hidePanel
{
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;	
	transition.subtype = kCATransitionFromTop;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, -self.frame.size.height, 320, self.frame.size.height); 
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

- (void)dealloc
{
    [super dealloc];
}

@end
