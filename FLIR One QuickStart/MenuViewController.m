//
//  MenuViewController.m
//  FLIR One QuickStart
//
//  Created by Rupesh on 12/14/14.
//  Copyright (c) 2014 Rupesh. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
@interface MenuViewController ()
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=NO;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:2];
    UIImageView *image=(UIImageView*)[cell.contentView viewWithTag:1];
    if (indexPath.row==0) {
        image.image=[UIImage imageNamed:@"playbutton.png"];
        lbl.text=@"SMS";
        
    }
    else if (indexPath.row==1)
    {
        image.image=[UIImage imageNamed:@"playbutton.png"];
        lbl.text=@"Flashlight";
        
    }
    else if (indexPath.row==2)
    {
        image.image=[UIImage imageNamed:@"playbutton.png"];
        lbl.text=@"Call";
        
    }
    else if (indexPath.row==3)
    {
        image.image=[UIImage imageNamed:@"playbutton.png"];
        lbl.text=@"Buzz";
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex=indexPath.row;

    if (indexPath.row==0)
    {
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldSendSMS]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
                [alert show];

             
            }
    }
    else  if (indexPath.row==1)
    {
        
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldFlashLight]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
            
            
        }


   }
    else  if (indexPath.row==2)
    {
        
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldCall]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
            
            
        }
        
        
    }

    else  if (indexPath.row==3)
    {
        
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldBuzz]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
            
            
        }
        
        
    }
    else  if (indexPath.row==4)
    {
        
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldVibrate]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
            
            
        }
        
        
    }
    else  if (indexPath.row==5)
    {
        
        if ([(ViewController*)self.navigationController.viewControllers[0] shouldTakePhoto]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Alarm already set" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to set alarm" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"Confirm", nil];
            [alert show];
            
            
        }
        
        
    }


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex==1) {
        if (self.selectedIndex==0)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldSendSMS:YES];
            [(ViewController*)self.navigationController.viewControllers[0] sendSMS];
        }
        else  if (self.selectedIndex==1)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldFlashLight:YES];
            
            [(ViewController*)self.navigationController.viewControllers[0] flashLight];
            
        }
        else  if (self.selectedIndex==2)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldCall:YES];
            
            [(ViewController*)self.navigationController.viewControllers[0] call];
            
        }

        else  if (self.selectedIndex==3)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldBuzz:YES];
            
            [(ViewController*)self.navigationController.viewControllers[0] buzz];
            
        }
        else  if (self.selectedIndex==4)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldVibrate:YES];
            
            [(ViewController*)self.navigationController.viewControllers[0] vibrate];
            
        }
        

        else  if (self.selectedIndex==5)
        {
            [(ViewController*)self.navigationController.viewControllers[0] setShouldTakePhoto:YES];
            
            [(ViewController*)self.navigationController.viewControllers[0] takePhoto];
            
        }
        


        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
