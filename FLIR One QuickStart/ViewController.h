#import <UIKit/UIKit.h>
#import <FLIROneSDK/FLIROneSDK.h>
#import "NMRangeSlider.h"
#import <MessageUI/MessageUI.h>
@interface ViewController : UIViewController<FLIROneSDKImageReceiverDelegate,FLIROneSDKStreamManagerDelegate,MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)IBOutlet UIImageView *thermalImageView;
//@property(strong,nonatomic)UIImage *thermalImage,*thermalImage1;
@property (weak, nonatomic) IBOutlet UILabel *lowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperLabel;
@property (weak, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (assign, nonatomic) BOOL shouldSendSMS;
@property (assign, nonatomic) BOOL shouldFlashLight;
@property (assign, nonatomic) BOOL shouldBuzz;
@property (assign, nonatomic) BOOL shouldCall;
@property (assign, nonatomic) BOOL shouldVibrate;
@property (assign, nonatomic) BOOL shouldTakePhoto;

-(void)sendSMS;
-(void)flashLight;
-(void)buzz;
-(void)call;
-(void)vibrate;
-(void)takePhoto;

//@property (strong, nonatomic) NSData *thermalData;
//@property (nonatomic) CGSize thermalSize;

@end

