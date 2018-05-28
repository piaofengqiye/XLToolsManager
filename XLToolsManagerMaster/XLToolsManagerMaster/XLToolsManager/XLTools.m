//
//  XLTools.m
//  XLToolsManagerMaster
//
//  Created by xl on 2018/5/26.
//  Copyright © 2018年 七叶昔洛. All rights reserved.
//

#import "XLTools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation XLTools

/**
 系统颜色
 */
+ (UIColor *)xl_black {
    return [UIColor blackColor];
}
+ (UIColor *)xl_darkGray {
    return [UIColor darkGrayColor];
}
+ (UIColor *)xl_lightGray {
    return [UIColor lightGrayColor];
}
+ (UIColor *)xl_white {
    return [UIColor whiteColor];
}
+ (UIColor *)xl_gray {
    return [UIColor grayColor];
}
+ (UIColor *)xl_red {
    return [UIColor redColor];
}
+ (UIColor *)xl_green {
    return [UIColor greenColor];
}
+ (UIColor *)xl_blue {
    return [UIColor blueColor];
}
+ (UIColor *)xl_cyan {
    return [UIColor cyanColor];
}
+ (UIColor *)xl_yellow {
    return [UIColor yellowColor];
}
+ (UIColor *)xl_magenta {
    return [UIColor magentaColor];
}
+ (UIColor *)xl_orange {
    return [UIColor orangeColor];
}
+ (UIColor *)xl_purple {
    return [UIColor purpleColor];
}
+ (UIColor *)xl_brown {
    return [UIColor brownColor];
}
+ (UIColor *)xl_clear {
    return [UIColor clearColor];
}

/**
 随机色
 */
+ (UIColor *)xl_random {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}
/**
 设置16进制颜色
 */
+ (UIColor *)xlcolorWithHexColor:(long)hexValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0];
}
#pragma mark ------ 沙盒目录文件
/**
 沙盒目录文件
 */
+ (NSString *)xl_tempPath {
    return NSTemporaryDirectory();
}
+ (NSString *)xl_cachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}
+ (NSString *)xl_documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}
/**
 判断iPhone
 */
+ (BOOL)is_xl_iPhone {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}
+ (BOOL)is_xl_iPhone_5 {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height == 568.0);
}
+ (BOOL)is_xl_iPhone_6 {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height == 667.0);
}
+ (BOOL)is_xl_iPhone_6_Plus {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height == 736.0 && [[UIScreen mainScreen] bounds].size.width == 414.0);
}
+ (BOOL)is_xl_iPhone_X {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height == 812.0 && [[UIScreen mainScreen] bounds].size.width == 375.0);
}
/**
 iPhone navi, tab, status 高度
 */
+ (CGFloat)xl_statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}
+ (CGFloat)xl_naviBarHeight {
    return XLTools.xl_statusBarHeight + 44.0;
}
+ (CGFloat)xl_tabBarHeight {
    return XLTools.xl_statusBarHeight > 20.0 ? 83.0 : 49.0;
}
+ (CGFloat)xl_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)xl_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
/**
 当前系统时间,格式化输出
 */
+ (NSString *)xl_currentTime {
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:date];
    return dateStr  ;
}

/**
 当前系统时间戳
 */
+ (NSString *)xl_currentTimeZone {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}
/**
 信号强度
 */
+ (int)xl_WifiStrength {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    UIView *dataNetworkItemView = nil;
    for (UIView * subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    int signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    return signalStrength;
}



/**
 显示文字在window
 */
+ (void)showTextOnWidow:(NSString *)text delay:(NSTimeInterval)dalay {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:text preferredStyle:UIAlertControllerStyleAlert];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        //  过秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dalay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

/**
 正则判断手机号码地址格式
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

/**
 判断字符串是否为空
 */
+ (BOOL)isEmptyString:(id)string {
    return ([string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@""] || [string isEqual:@"NULL"]);
}
/**
 判断是空null
 */
+ (BOOL)isEmptyClass:(id)emClass {
    return ([emClass isKindOfClass:[NSNull class]] || [emClass isEqual:[NSNull null]] || [emClass isEqual:NULL]);
}

/**
 正则判断密码格式
 */
+ (BOOL)isPassword:(NSString *)password {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}
/**
 正则判断密码格式, 默认(6-12位中,英文,数字)
 */
+ (BOOL)isPassword:(NSString *)password format:(NSString*)format {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,12}+$";
    if (![self isEmptyString:format]) {
        passWordRegex = format;
    }
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

/**
 时间戳转换时间
 */
+ (NSString *)timeTransFromTimestamp:(NSString *)stamp {
    NSDate * timenow = [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:timenow];
}

/**
 时间转换时间戳
 */
+ (NSString *)timestampFormTime:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *lastDate = [formatter dateFromString:time];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long firstStamp = [lastDate timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", firstStamp];
}
/**
 时间戳转换时间(按固定格式:YYYY-MM-dd HH:mm:ss )
 */
+ (NSString *)timeTransFromTimestamp:(NSString *)stamp format:(NSString *)format {
    NSDate * timenow = [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:timenow];
}
/**
 设置rgba颜色(eg:(100, 103, 256, 0.4)
 */
+ (UIColor *)xlcolorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:(alpha)];
}
/**
 字典/数组 转json
 */
+ (NSString*)dictionaryToJson:(id)objc {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:nil error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 读取本地JSON文件
 */
+ (NSDictionary *)readLocalJSONFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark --- UIImage
/**
 *  根据颜色生成一张图片
 *  @param color 提供的颜色
 */

+ (UIImage *)imageWithColor:(UIColor *)color {
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    //渲染上下文
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ------ UILabel

/**
 创建UILabel
 */
+ (UILabel *)labelWithTitle:(NSString *)title font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@", title];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}

#pragma mark ------ UIImageView

/**
 生成二维码
 
 @param imageView 需要展示二维码的视图
 @param url 生成二维码的字符串
 */
+ (void)QRDroidImageView:(UIImageView *)imageView url:(NSString *)url size:(CGFloat)size Red:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue {
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:url] withSize:size];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:red andGreen:green andBlue:blue];
    imageView.image = customQrcode;
    // set shadow,  可以不设置
    //    imageView.layer.shadowOffset = CGSizeMake(0, 2);
    //    imageView.layer.shadowRadius = 2;
    //    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    imageView.layer.shadowOpacity = 0.5;
}

+ (void)QRDroidImageView:(UIImageView *)imageView url:(NSString *)url {
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:url] withSize:250.0f];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
    imageView.image = customQrcode;
    // set shadow,  可以不设置
    //    imageView.layer.shadowOffset = CGSizeMake(0, 2);
    //    imageView.layer.shadowRadius = 2;
    //    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    imageView.layer.shadowOpacity = 0.5;
}
#pragma mark - InterpolatedUIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
+ (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

#pragma mark ------ 清理缓存文件
/**
 *
 *  获取path路径文件夹的大小
 *
 *  @param path 要获取大小的文件夹全路径
 *
 *  @return 返回path路径文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //调试
#ifdef DEBUG
    //如果文件夹不存在或者不是一个文件夹那么就抛出一个异常
    //抛出异常会导致程序闪退，所以只在调试阶段抛出，发布阶段不要再抛了,不然极度影响用户体验
    BOOL isDirectory = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory)
    {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"please check your filePath!" userInfo:nil];
        [exception raise];
        
    }
//    NSLog(@"debug");
    //发布
#else
//    NSLog(@"post");
#endif
    
    //获取“path”文件夹下面的所有文件
    NSArray *subpathArray= [fileManager subpathsAtPath:path];
    
    NSString *filePath = nil;
    NSInteger totleSize=0;
    
    for (NSString *subpath in subpathArray)
    {
        //拼接每一个文件的全路径
        filePath =[path stringByAppendingPathComponent:subpath];
        
        
        
        //isDirectory，是否是文件夹，默认不是
        BOOL isDirectory = NO;
        
        //isExist，判断文件是否存在
        BOOL isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        //判断文件是否存在，不存在的话过滤
        //如果存在的话，那么是否是文件夹，是的话也过滤
        //如果文件既存在又不是文件夹，那么判断它是不是隐藏文件，是的话也过滤
        //过滤以上三个情况后，就是一个文件夹里面真实的文件的总大小
        //以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        //NSLog(@"%@",filePath);
        //指定路径，获取这个路径的属性
        //attributesOfItemAtPath:需要传文件夹路径
        //但是attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，这个也就是需要for-in遍历文件夹里面每一个文件的原因
        NSDictionary *dict=   [fileManager attributesOfItemAtPath:filePath error:nil];
        
        NSInteger size=[dict[@"NSFileSize"] integerValue];
        totleSize+=size;
    }
    
    //将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000)
    {
        totleStr = [NSString stringWithFormat:@"%.1fM",totleSize / 1000.0f /1000.0f];
    }else if (totleSize > 1000)
    {
        totleStr = [NSString stringWithFormat:@"%.1fKB",totleSize / 1000.0f ];
        
    }else
    {
        totleStr = [NSString stringWithFormat:@"%.1fB",totleSize / 1.0f];
    }
    
    return totleStr;
}

/**
 *
 *  清除path路径文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹全路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path {
     NSFileManager *fileManager = [NSFileManager defaultManager];
    //拿到path路径的下一级目录的子文件夹
    NSArray *subpathArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    NSString *message = nil;
    NSError *error = nil;
    NSString *filePath = nil;
    
    for (NSString *subpath in subpathArray)
    {
        filePath =[path stringByAppendingPathComponent:subpath];
        //删除子文件夹
        [fileManager removeItemAtPath:filePath error:&error];
        if (error) {
            message = [NSString stringWithFormat:@"%@这个路径的文件夹删除失败了，请检查后重新再试",filePath];
            return NO;
            
        }else {
            message = @"成功了";
        }
        
    }
    NSLog(@"%@",message);
    
    return YES;
}
#pragma mark --- MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// MD5加密,32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str {
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
// MD5加密,32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str {
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}
// MD5加密,16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str {
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
// MD5加密,16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str {
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark --- base64加密,解密

/**
 对一个字符串进行base64编码
 */
+(NSString *)base64EncodeString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
/**
 对一个字符串进行base解码
 */
+(NSString *)base64decodeString:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
