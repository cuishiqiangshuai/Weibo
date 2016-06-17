//
//  LoginVC.m
//  Weibo
//
//  Created by qingyun on 16/6/6.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "LoginVC.h"
#import "ConfigFile.h"

@interface LoginVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWeb;

@end

@implementation LoginVC

//获取临时token
-(void)requestTempToken{
    /*
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:GetTokenPath]];
    //设置请求参数
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //body
    NSString *bodyStr=[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",APPKEY,REDIRECTURL];
    request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //seesion对象
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"=====%@",str);
       
    }];
   
    [task resume];
     */

    _myWeb.scalesPageToFit=YES;
    _myWeb.delegate=self;
    
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:GetTokenPath]];
    //设置请求参数
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //body
    NSString *bodyStr=[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",APPKEY,REDIRECTURL];
    request.HTTPBody=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_myWeb loadRequest:request];
}

-(void)getAccessToken:(NSString *)code{
  //网络请求

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取URL
    NSURL *url=[request URL];
    //转换成string
    NSString*strUrl=[url absoluteString];
    //判断回调地址是否以回调地址开头http://www.hnqingyun.com如果是,从链接地址获取code的值 code主要用于获取access_token
    if([strUrl hasPrefix:REDIRECTURL]){
    //http://www.hnqingyun.com/?code=0e5b454ad34c9443a0a8850169869270
        //该方法是以"="为分割点,截取字符串,最终放在数组里
        NSArray *arr=[strUrl componentsSeparatedByString:@"="];
         NSString *code=[arr lastObject];
        NSLog(@"======%@",code);
       //code获取完毕后,请求换取Acces_token
        [self getAccessToken:code];
    }
    return YES;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestTempToken];
    // Do any additional setup after loading the view.
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
