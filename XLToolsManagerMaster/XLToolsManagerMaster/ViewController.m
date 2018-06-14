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
@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary* dataDic = [XLTools readLocalJSONFileWithName:@"github-iphone"];
    NSDictionary *dic = [[dataDic objectForKey:@"repositories"] firstObject];
    NSString *keyStr = [XLTools xl_printStringForOCWithData:dic];
    NSLog(@"\n%@", keyStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
