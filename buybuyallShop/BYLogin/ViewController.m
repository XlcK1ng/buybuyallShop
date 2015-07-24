//
//  ViewController.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/21.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize: 14];
    btnLogin.titleLabel.textColor = [UIColor whiteColor];
    
    [btnLogin setBackgroundColor:[UIColor blackColor]];
    [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    btnLogin.frame = CGRectMake(20, 40.f, 100, 44.f);
    [self.view addSubview: btnLogin];
    
    
    UIButton *messageLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageLogin setTitle:@"message" forState:UIControlStateNormal];
    messageLogin.titleLabel.font = [UIFont systemFontOfSize: 14];
    messageLogin.titleLabel.textColor = [UIColor whiteColor];
    
    [messageLogin setBackgroundColor:[UIColor blackColor]];
    [messageLogin addTarget:self action:@selector(cliackAction:) forControlEvents:UIControlEventTouchUpInside];
    messageLogin.frame = CGRectMake(20, 70.f, 100, 44.f);
    [self.view addSubview: messageLogin];
    
}

-(void) btnLoginClick: (id) sender
{
    //[self showLoading:@"获取数据"];
    
    
    /*两种方法*/
    
    //方法一：直接初始化基类请求
    bizObject *biz = [[bizObject alloc]initWithUrl:@"bba-crm/crm/login"];
    biz.delegate  = self;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity: 1];
    NSString* password = @"13888888888";
    NSString* md5Password = [password stringFromMD5];
    NSString* staticPassword = [md5Password stringByAppendingString:@"com.bba.crm.token"];
    NSString* md5StaticPassword = [staticPassword stringFromMD5];
    
    
    [dict setObject:@"13888888888" forKey:@"username"];
    [dict setObject:md5Password forKey:@"password"];
    [dict setObject:md5StaticPassword forKey:@"token"];

     [biz postData: dict];
     return;
    
    //方法二：新建继续基类对象请求
//    twUser *objTmp = [[twUser alloc]init];//WithUrl:@"login/submit.jhtml"];
//    objTmp.delegate = self;
//    objTmp.username = @"郭贤龙";
//    objTmp.password = @"1234";
//    [objTmp post];
    
    

}




-(void)cliackAction:(UIButton*)sender{
    
    bizObject* getMessage  = [[bizObject alloc]initWithUrl:@"sms/postMsg"];
    getMessage.delegate  = self;
    NSMutableDictionary *getMessage_dict = [[NSMutableDictionary alloc]initWithCapacity: 1];
    NSInteger armNumber  = (arc4random() % 9999) + 1000;
    NSString* numberStr  = [NSString stringWithFormat:@"%ld",armNumber];
    
    [getMessage_dict setObject:@"18575859493" forKey:@"mobile"];
    [getMessage_dict setObject:numberStr forKey:@"content"];
    
    [getMessage postData: getMessage_dict];

}




-(void) didAfterPost: (NSString*)  url  dict: (NSDictionary *)  bizObj
{
    // [self ShowDismiss];
    NSLog(@"url=%@ obj=%@", url, bizObj);
    
//    if ([url hasSuffix:@"login/submit.jhtml"])
//    {
//        
//        //登录成功后，需要把用户ＩＤ等信息存储在本地
//        NSString *PATH = [NSFileManager pathForDocumentName:[NSString stringWithFormat:@"/%@",KuserArchive]];
//        //NSData  *data1 = [NSKeyedArchiver archivedDataWithRootObject:dict];
//        
//        //[LoginParse setObjects:nil toDict:dict];
//        [bizObj writeToFile:PATH atomically:YES];
//        
//        
//        [globalData refreshUserInfo];
//        [globalData userInfo];
//        
//        
//        lblUserName.text = [globalData userName];
//    }
//    else if ([url hasSuffix:@"receiver/list.jhtml"])
//    {
//        [self showHint:@"hello"];
//    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
