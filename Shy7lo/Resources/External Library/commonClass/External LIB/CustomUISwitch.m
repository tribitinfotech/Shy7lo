
#import "CustomUISwitch.h"

#define SWITCH_DISPLAY_WIDTH		50.0
#define SWITCH_WIDTH				50.0
#define SWITCH_HEIGHT				25.0

#define RECT_FOR_OFF		CGRectMake(-55.0, 0.0, SWITCH_WIDTH, SWITCH_HEIGHT)
#define RECT_FOR_ON			CGRectMake(0.0, 0.0, SWITCH_WIDTH, SWITCH_HEIGHT)
#define RECT_FOR_HALFWAY	CGRectMake(-27.5, 0.0, SWITCH_WIDTH, SWITCH_HEIGHT)

@interface CustomUISwitch ()
@property (nonatomic, retain, readwrite) UIImageView* backgroundImage;
@property (nonatomic, retain, readwrite) UIImageView* switchImage;
- (void)setupUserInterface;
- (void)toggle;
- (void)animateSwitch:(BOOL)toOn;
@end


@implementation CustomUISwitch
@synthesize backgroundImage = _backgroundImage;
@synthesize switchImage = _switchImage;
@synthesize delegate = _delegate;
@synthesize _on;

/**
 * Destructor
 */
- (void)dealloc
{
	[_backgroundImage release];
	[_switchImage release];
	[super dealloc];
}

/** 
 * Constructor
 */
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, SWITCH_DISPLAY_WIDTH, SWITCH_HEIGHT)]) 
	{
		self._on = YES;
		_hitCount = 0;

		self.backgroundColor = [UIColor clearColor];
		self.clipsToBounds = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = 0;
		self.opaque = YES;
		
		[self setupUserInterface];
    }
    return self;
}

/**
 * Setup the user interface
 */
- (void)setupUserInterface
{
	// Background image
	UIImageView* bg = [[UIImageView alloc] initWithFrame:RECT_FOR_ON];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    bg.image = [UIImage imageNamed:@"btn_switch_yes"];
   
	bg.backgroundColor = [UIColor greenColor];
	bg.contentMode = UIViewContentModeLeft;
	self.backgroundImage = bg;
	[bg release];
	
	// Switch image
//	UIImageView* foreground = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SWITCH_WIDTH, SWITCH_HEIGHT)];
//	foreground.image = [UIImage imageNamed:@"switch.png"];
//	foreground.contentMode = UIViewContentModeLeft;
//	self.switchImage = foreground;
//	[foreground release];

	// Check for user input
	[self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:self.backgroundImage];
	[self.backgroundImage addSubview:self.switchImage];
}

/**
 * Drawing Code
 */
- (void)drawRect:(CGRect)rect 
{
	// nothing
}

/**
 * Configure it into a certain state
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated
{
	self._on = on;
    
	if (self._on)
	{
        self.backgroundImage.image = [UIImage imageNamed:@"btn_switch_yes"];
    }
	else
	{
        self.backgroundImage.image = [UIImage imageNamed:@"btn_switch_no"];
    }
}

/**
 * Check if on
 */
- (BOOL)isOn
{
	return self._on;
}

/**
 * Capture user input
 */
- (void)buttonPressed:(id)target
{
	// We use a hit count to properly queue up multiple hits on the button while we are animating.
	if (_hitCount == 0)
	{
		_hitCount++;
		//[self toggle];
	}
	else
	{
		_hitCount++;
		// Do not animate, this will happen when other animation finishes
	}
}

/**
 * Toggle ison
 */
- (void)toggle
{
	_on = !_on;
	[self animateSwitch:_on];
}

/**
 * Animate the switch by sliding halfway and then changing the background image and then sliding the rest of the way.
 */
- (void)animateSwitch:(BOOL)toOn
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];

	self.switchImage.frame = RECT_FOR_HALFWAY;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationHasFinished:finished:context:)];

	if (toOn)
	{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lang = [defaults objectForKey:@"language"];
        if([lang isEqualToString:@"en"]) {
            
            self.backgroundImage.image = [UIImage imageNamed:@"bg_workshop_add_edit_mode_on.png"];
        }
        else {
            
           self.backgroundImage.image = [UIImage imageNamed:@"bg_workshop_add_edit_mode_on_cn.png"];
        }
        
		self.switchImage.frame = RECT_FOR_ON;
		
	}
	else
	{
		self.switchImage.frame = RECT_FOR_OFF;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lang = [defaults objectForKey:@"language"];
        if([lang isEqualToString:@"en"]) {
            
            self.backgroundImage.image = [UIImage imageNamed:@"bg_workshop_add_edit_mode_off.png"];
        }
        else {
            
            self.backgroundImage.image = [UIImage imageNamed:@"bg_workshop_add_edit_mode_off_cn.png"];
        }
        
		
	}
	[UIView commitAnimations];
	
	[UIView commitAnimations];
}

/**
 * Remove the view no longer visible
 */
- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
	if (_delegate)
	{
		[_delegate valueChangedInView:self];
	}
	
	// We use a hit count to properly queue up multiple hits on the button while we are animating.
	if (_hitCount > 1)
	{
		_hitCount--;
		[self toggle];
	}
	else
	{
		_hitCount--;
	}
}

@end