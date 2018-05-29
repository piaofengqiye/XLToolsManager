//
//  ViewController.m
//  XLToolsManagerMaster
//
//  Created by xl on 2018/5/26.
//  Copyright © 2018年 七叶昔洛. All rights reserved.
//

#import "ViewController.h"
#import "XLTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = XLTools.xl_random;
    NSString *tempNum = [XLTools getCacheSizeWithFilePath:XLTools.xl_tempPath];
    NSString *docuNum = [XLTools getCacheSizeWithFilePath:XLTools.xl_documentPath];
    NSString *cacheNum = [XLTools getCacheSizeWithFilePath:XLTools.xl_cachePath];
    NSLog(@"%@, %@, %@", tempNum, docuNum, cacheNum);
    NSString *day = [XLTools timeTransFromTimestamp:XLTools.xl_currentTimeZone format:@"yyyy-MM-dd HH:mm:ss EEEE"];
    NSLog(@"%@", day);
    [day capitalizedString];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
