#import "ViewController.h"
#import "MenuViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic) NSInteger counter;

@property (strong, nonatomic) NSData *thermalData;
@property (nonatomic) CGSize thermalSize;

@property (strong, nonatomic) UIImage *thermalImage;
@property (strong, nonatomic) UIImage *thermalImage1;
@property (assign, nonatomic) BOOL thermalStatus;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[FLIROneSDKStreamManager sharedInstance] addDelegate:self];
    [[FLIROneSDKStreamManager sharedInstance] setImageOptions:FLIROneSDKImageOptionsVisualYCbCr888Image|FLIROneSDKImageOptionsThermalRadiometricKelvinImage];
    
    [self configureLabelSlider];
    self.lowerLabel.text=@"-50";
    self.upperLabel.text=@"130";
    self.shouldFlashLight=NO;
    self.shouldSendSMS=NO;


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;

}
- (void)FLIROneSDKDelegateManager:(FLIROneSDKDelegateManager *)delegateManager didReceiveFrameWithOptions:(FLIROneSDKImageOptions)options metadata:(FLIROneSDKImageMetadata *)metadata {
    self.counter = 0;
}
- (void)FLIROneSDKDelegateManager:(FLIROneSDKDelegateManager *)delegateManager didReceiveVisualYCbCr888Image:(NSData *)visualYCbCr888Image imageSize:(CGSize)size {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.thermalImage = [FLIROneSDKUIImage imageWithFormat:FLIROneSDKImageOptionsVisualYCbCr888Image andData:visualYCbCr888Image andSize:size];
        
        //increment counter here
        //check if counter >= 2
        //if it is, do special code involving both data sets
        self.counter += 1;
        if (self.counter >= 2)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.thermalImage1=self.thermalImage;
                // [self updateUI];
                self.thermalImageView.image=[self modifyImage:self.thermalImage1];
            });
        }
    });
    

    
    //[self updateUI];
}
- (void)FLIROneSDKDelegateManager:(FLIROneSDKDelegateManager *)delegateManager didReceiveBlendedMSXRGBA8888Image:(NSData *)msxImage imageSize:(CGSize)size{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.thermalImage = [FLIROneSDKUIImage imageWithFormat:FLIROneSDKImageOptionsBlendedMSXRGBA8888Image andData:msxImage andSize:size];
        
        //increment counter here
        //check if counter >= 2
        //if it is, do special code involving both data sets
        self.counter += 1;
        if (self.counter >= 2)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.thermalImage1=self.thermalImage;
                // [self updateUI];
                self.thermalImageView.image=[self modifyImage:self.thermalImage1];
            });
        }
    });
    
    //[self updateUI];
}
- (void)FLIROneSDKDelegateManager:(FLIROneSDKDelegateManager *)delegateManager didReceiveRadiometricData:(NSData *)radiometricData imageSize:(CGSize)size {
    
    @synchronized(self) {
        self.thermalData = radiometricData;
        self.thermalSize = size;
    }
    
    self.counter +=1;
    if (self.counter >= 2)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thermalImage1=self.thermalImage;
            // [self updateUI];
            self.thermalImageView.image=[self modifyImage:self.thermalImage1];
            
            
        });
    }
    
    //[self updateUI];
}
-(void)updateUI
{
  //  [self.thermalImageView setImage:self.thermalImage];


}
- (void) performTemperatureCalculations {


//    uint16_t *tempData = (uint16_t *)[self.thermalData bytes];
//    uint16_t temp = tempData[0];
//    uint16_t hottestTemp = temp;
//    uint16_t coldestTemp = temp;
//    int index = 0;
//    int coldIndex = 0;
//    
//    for(int i=0;i<self.thermalSize.width*self.thermalSize.height;i++) {
//        temp = tempData[i];
//        if(temp > hottestTemp) {
//            hottestTemp = temp;
//            index = i;
//        }
//        if(temp < coldestTemp) {
//            coldestTemp = temp;
//            coldIndex = i;
//        }
//    }
    
//    UIImage *image      = thermalImage;
//    CGImageRef imageRef = image.CGImage;
//    NSData *data        = (NSData *)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(imageRef)));
//    char *pixels        = (char *)[data bytes];
//    
//    // this is where you manipulate the individual pixels
//    // assumes a 4 byte pixel consisting of rgb and alpha
//    // for PNGs without transparency use i+=3 and remove int a
//    int j=0;
//    for(int i = 0; i < [data length]; i += 4)
//    {
//        int r = i;
//        int g = i+1;
//        int b = i+2;
//        int a = i+3;
//        
//        uint16_t *tempData = (uint16_t *)[self.thermalData bytes];
//        uint16_t temp = tempData[j]/100;
//
//        j++;
//        pixels[r]   = pixels[r]; // eg. remove red
//        pixels[g]   =0;
//        pixels[b]   = 0;
//        pixels[a]   = pixels[a];
//    }
//    
//    // create a new image from the modified pixel data
//    size_t width                    = CGImageGetWidth(imageRef);
//    size_t height                   = CGImageGetHeight(imageRef);
//    size_t bitsPerComponent         = CGImageGetBitsPerComponent(imageRef);
//    size_t bitsPerPixel             = CGImageGetBitsPerPixel(imageRef);
//    size_t bytesPerRow              = CGImageGetBytesPerRow(imageRef);
//    
//    CGColorSpaceRef colorspace      = CGColorSpaceCreateDeviceRGB();
//    CGBitmapInfo bitmapInfo         = CGImageGetBitmapInfo(imageRef);
//    CGDataProviderRef provider      = CGDataProviderCreateWithData(NULL, pixels, [data length], NULL);
//    
//    CGImageRef newImageRef = CGImageCreate (
//                                            width,
//                                            height,
//                                            bitsPerComponent,
//                                            bitsPerPixel,
//                                            bytesPerRow,
//                                            colorspace,
//                                            bitmapInfo,
//                                            provider,
//                                            NULL,
//                                            false,
//                                            kCGRenderingIntentDefault
//                                            );
//    // the modified image
//    UIImage *newImage   = [UIImage imageWithCGImage:newImageRef];
//    thermalImageView.image=newImage;
    
    // cleanup
   // free(pixels);
//    CGImageRelease(imageRef);
//    CGColorSpaceRelease(colorspace);
//    CGDataProviderRelease(provider);
   // CGImageRelease(newImageRef);
       // thermalImageView.image=[self ModifyImage:thermalImage];
   // [self.thermalImageView setImage:self.thermalImage];
    
}

//120 * 160
//create a new rgba array with 120 * 160 * 4 (4 bytes per pixel)
//populate it with normalized temperature values received from the Radiometric kelvin datastream
//create a UIImagewithcontext with datasource
//
////Generate the shape as image so that we can make pattern out of it.
//CGContextRef conPattern = CGBitmapContextCreate(NULL,
//                                                shp.size.width,
//                                                shp.size.height,
//                                                8,
//                                                0,
//                                                rgbColorSpace,
//                                                kCGImageAlphaPremultipliedFirst);



-(UIImage*)modifyImage:(UIImage*) img
{
    
   // unsigned char *rawImageData = (unsigned char *)[self.imageData bytes];
    
    size_t width = 120;
    size_t height = 160;
    size_t bytesPerPixel = 4;
        uint16_t *tempData = (uint16_t *)[self.thermalData bytes];
    int k=0,m=0;
  unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    for (int x = 0 ; x < 120*160*4 ; x=x+4)
        {
            
            int lower=[self.lowerLabel.text integerValue]+273.15;
            int higher=[self.upperLabel.text integerValue]+273.15;
            uint16_t temp = tempData[k]/100;
            //int t=  0 +  ( (temp - 220)* (255 - 0) / (400 - 220) );
            int t = 0 +  ( (temp - lower) * (255 - 0) / (higher - lower) );
            rawData[x]    = t;
                    rawData[x+1]  = 0;
                    rawData[x+2]  = 0;

            if (self.segment.selectedSegmentIndex==0) {
                if (lower<temp&&higher>temp)
                    rawData[x+3]  = 0;
                
                else
                {
                    rawData[x+3]  = 0;
                    m++;
                }

            }
            else if (self.segment.selectedSegmentIndex==1) {
                if (lower<temp&&higher>temp)
                    rawData[x+3]  = 0;
                
                else
                {
                    rawData[x+3]  = 255;
                   m++;
                }
                
            }
            else if (self.segment.selectedSegmentIndex==2) {
                if (lower<temp&&higher>temp)
                    rawData[x+3]  =255;
                
                else
                {
                    rawData[x+3]  = 0;
                    m++;
                }
                
            }
            
            else
            {
                if (lower<temp&&higher>temp)
                    rawData[x+3]  = 255;
                
                else
                {
                    rawData[x+3]  = 255;
                    m++;
                }
                
            }
            


            k++;
        }

    if (m>=200)
    {
        self.thermalStatus=YES;
        [self sendSMS];
        [self flashLight];
        [self buzz];
        [self call];
        [self vibrate];
        [self takePhoto];

        
    }
    else
        self.thermalStatus=NO;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bytesPerRow = bytesPerPixel * width;
    size_t bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    //This is your image:
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    //Don't forget to clean up:
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *bottomImage =img;
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Apply supplied opacity
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    /*UIGraphicsBeginImageContext(img.size);
    
    [img drawInRect:CGRectMake(0,0,img.size.width,img.size.height) blendMode:kCGBlendModeSourceOut alpha:1.0f];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    unsigned char* data = CGBitmapContextGetData (ctx);
    
    for (int y = 0 ; y < img.size.height ; y++)
    {
        for (int x = 0 ; x < img.size.width ; x++)
        {
            //int offset = 4 * ((w * y) + x);
            
            int offset = (CGBitmapContextGetBytesPerRow(ctx)*y) + (4 * x);
            uint16_t red;

            if (self.thermalData) {
                uint16_t *tempData = (uint16_t *)[self.thermalData bytes];
                uint16_t temp = tempData[offset]/100;
                red= 255*temp/373;
                if (red>270)
                {
                    data[offset]    = 0;
                    data[offset+1]  = 0;
                    data[offset+2]  = data[offset+2];
                    data[offset+3]  = data[offset+3];
                }
                else if (red<270)
                {
                    data[offset]    = data[offset];
                    data[offset+1]  = 0;
                    data[offset+2]  = 0;
                    data[offset+3]  = data[offset+3];
                }
            }
        }
    }
    
    UIImage *rtimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rtimg;*/
    return img;
}

- (void) updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.labelSlider.lowerCenter.x + self.labelSlider.frame.origin.x);
    lowerCenter.y = (self.labelSlider.center.y + 30.0f);
    self.lowerLabel.center = lowerCenter;
    self.lowerLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.labelSlider.upperCenter.x + self.labelSlider.frame.origin.x);
    upperCenter.y = (self.labelSlider.center.y + 30.0f);
    self.upperLabel.center = upperCenter;
    self.upperLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.upperValue];
}
- (void) configureLabelSlider
{
    self.labelSlider.minimumValue = -50;
    self.labelSlider.maximumValue = 130;
    
    self.labelSlider.lowerValue = -50;
    self.labelSlider.upperValue = 130;
    
    self.labelSlider.minimumRange = 10;
}

// Handle control value changed events just like a normal slider
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    [self updateSliderLabels];
}
-(IBAction)ok:(id)sender
{
    MenuViewController *menu=[self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    menu.thermalStatus=self.thermalStatus;
    [self.navigationController pushViewController:menu animated:YES];
}
-(void)sendSMS
{

    if (self.thermalStatus&&self.shouldSendSMS) {
        self.shouldSendSMS=NO;
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = @"SMS message here";
            controller.recipients = [NSArray arrayWithObjects:@"1(234)567-8910", nil];
            controller.messageComposeDelegate = self;
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }

    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)flashLight
{
    if (self.thermalStatus&&self.shouldFlashLight) {
        self.shouldFlashLight=NO;


    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (device.torchMode==AVCaptureTorchModeOn)
            [device setTorchMode:AVCaptureTorchModeOff];  // use AVCaptureTorchModeOff to turn off
        
        else
            [device setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
        [device unlockForConfiguration];
    }
    }

}
-(void)buzz
{
    if (self.thermalStatus&&self.shouldBuzz) {
        self.shouldBuzz=NO;
        
        
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"soundeffect" ofType:@"m4a"];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        SystemSoundID audioEffect;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
        // Using GCD, we can use a block to dispose of the audio effect without using a NSTimer or something else to figure out when it'll be finished playing.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AudioServicesDisposeSystemSoundID(audioEffect);
        });    }
    
}
-(void)call
{
    if (self.thermalStatus&&self.shouldCall) {
        self.shouldCall=NO;
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:@"12344"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}
-(void)vibrate
{
    if (self.thermalStatus&&self.shouldVibrate) {
        self.shouldVibrate=NO;
        
     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}
-(void)takePhoto
{
    if (self.thermalStatus&&self.shouldTakePhoto) {
        self.shouldTakePhoto=NO;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = NO;
        
        [self.navigationController presentViewController:picker animated:YES
                         completion:^ {
                             [picker takePicture];
                         }];
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get Image URL from Library
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image,
                                   nil,
                                   nil,
                                   nil);
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
