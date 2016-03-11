//
//  ViewController.m
//  FacebookLoginExample
//
//  Created by CHYAU FUH CHANG on 2016/3/11.
//  Copyright © 2016年 iOTEC. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.fbLoginButton.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginButton:	(FBSDKLoginButton *)loginButton
didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
              error:	(NSError *)error
{
    NSLog(@"result=%@",result);
    NSLog(@"error=%@",error);
}
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

@end
