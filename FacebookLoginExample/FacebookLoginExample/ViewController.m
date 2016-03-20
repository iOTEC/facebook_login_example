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
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

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
    if (result.isCancelled==YES) {
        NSLog(@"User login canceled.");
    }else{
        NSLog(@"grantedPermissions=%@",result.grantedPermissions);
        FBSDKAccessToken *token=result.token;
        NSLog(@"userID=%@",token.userID);
        NSLog(@"tokenString=%@",token.tokenString);
        
        if ([result.grantedPermissions containsObject:@"email"]) {
            if ([FBSDKAccessToken currentAccessToken]) {
                NSDictionary *param = @{@"fields" : @"email"};
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:param] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error && result!=nil) {
                        if([result isKindOfClass:[NSDictionary class]])
                        {
                            NSLog(@"email=%@",result[@"email"]);
                            
                            if ([FBSDKAccessToken currentAccessToken]) {
                                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                    if (!error) {
                                        NSString *nameOfLoginUser = [result valueForKey:@"name"];
                                        NSLog(@"name=%@",nameOfLoginUser);
                                        
                                        NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                                        
                                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStringOfLoginUser]];
                                        self.imageView.image = [UIImage imageWithData:imageData];
                                    }
                                }];
                            }
                        }
                    }
                }];
            }
        } else {
            NSLog(@"Not granted");
        }
    }
    if(error != nil)
        NSLog(@"error=%@",error);
}
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

@end
