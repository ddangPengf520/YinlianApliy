//
//  ViewController.m
//  YinLian
//
//  Created by dpfst520 on 15/12/1.
//  Copyright © 2015年 pengfei.dang. All rights reserved.
//

#import "ViewController.h"

#import "DdNetWork.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"

@interface ViewController ()<UPPayPluginDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"银联支付";
    UIButton *payButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    payButton.frame = CGRectMake(50, 100, self.view.frame.size.width - 100, 60);
    payButton.backgroundColor = [UIColor lightGrayColor];
    [payButton setTitle:@"银联支付" forState:UIControlStateNormal];
    [payButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    payButton.layer.cornerRadius = 5;
    [payButton setImageEdgeInsets:UIEdgeInsetsMake(5, -20, 0, 0)];
    [payButton addTarget:self action:@selector(upPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
}

- (void)upPayAction:(UIButton *)sender
{
    NSString *unPayStr = [NSString stringWithFormat:@"",@""];
    unPayStr = [unPayStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [DdNetWork getRequestWithURLString:unPayStr Parameters:nil RequestHead:nil DataReturnType:DataReturnTypeData SuccessBlock:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        NSString *tn = [NSString stringWithFormat:@"%@", [[myDic objectForKey:@""] objectForKey:@""]];
        if (tn != nil && tn.length > 0) {
            [UPPayPlugin startPay:tn mode:@"00" viewController:self delegate:self];
        }
    } FailureBlock:^(NSData *error) {
        NSLog(@"error ----> %@", error);
    }];
}

- (void)UPPayPluginResult:(NSString *)result
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:result preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
