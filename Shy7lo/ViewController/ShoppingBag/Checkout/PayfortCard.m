//
//  test.m
//  Shy7lo
//
//  Created by Jitendra bhadja on 28/04/17.
//  Copyright © 2017 jitendra bhadja. All rights reserved.
//

#import "PayfortCard.h"

@implementation PayfortCard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
@implementation PayFortView (checkBox)

- (IBAction)btnCheckBoxRegisterNewsLetterAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.isSelected) {
        btn.selected = false;
        
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"NewsLetter"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        btn.selected = true;
        
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"NewsLetter"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)btnCHeckBoxAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.isSelected) {
        btn.selected = false;
        
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"BillingAddress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        btn.selected = true;
        
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BillingAddress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
