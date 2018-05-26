//
//  XLTools.h
//  XLToolsManagerMaster
//
//  Created by xl on 2018/5/26.
//  Copyright © 2018年 七叶昔洛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLTools : NSObject

#pragma mark ------ 颜色
/**
 系统颜色
 */
@property(class, nonatomic, readonly) UIColor *xl_black;      // 0.0 white
@property(class, nonatomic, readonly) UIColor *xl_darkGray;   // 0.333 white
@property(class, nonatomic, readonly) UIColor *xl_lightGray;  // 0.667 white
@property(class, nonatomic, readonly) UIColor *xl_white;      // 1.0 white
@property(class, nonatomic, readonly) UIColor *xl_gray;       // 0.5 white
@property(class, nonatomic, readonly) UIColor *xl_red;        // 1.0, 0.0, 0.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_green;      // 0.0, 1.0, 0.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_blue;       // 0.0, 0.0, 1.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_cyan;       // 0.0, 1.0, 1.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_yellow;     // 1.0, 1.0, 0.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_magenta;    // 1.0, 0.0, 1.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_orange;     // 1.0, 0.5, 0.0 RGB
@property(class, nonatomic, readonly) UIColor *xl_purple;     // 0.5, 0.0, 0.5 RGB
@property(class, nonatomic, readonly) UIColor *xl_brown;      // 0.6, 0.4, 0.2 RGB
@property(class, nonatomic, readonly) UIColor *xl_clear;      // 0.0 white, 0.0 alpha
/**
 随机色
 */
@property(class, nonatomic, readonly) UIColor *xl_random;

/**
 设置rgba颜色(eg:(100, 103, 256, 0.4)
 */
+ (UIColor *)xlcolorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 设置16进制颜色
 */
+ (UIColor *)xlcolorWithHexColor:(long)hexValue;
#pragma mark ------ iPhone 尺寸
/**
 判断iPhone
 */
@property(class, nonatomic, readonly) BOOL is_xl_iPhone;
@property(class, nonatomic, readonly) BOOL is_xl_iPhone_5;
@property(class, nonatomic, readonly) BOOL is_xl_iPhone_6;
@property(class, nonatomic, readonly) BOOL is_xl_iPhone_6_Plus;
@property(class, nonatomic, readonly) BOOL is_xl_iPhone_X;
/**
 iPhone navi, tab, status 高度, sceen 宽高
 */
@property(class, nonatomic, readonly) CGFloat xl_statusBarHeight;
@property(class, nonatomic, readonly) CGFloat xl_naviBarHeight;
@property(class, nonatomic, readonly) CGFloat xl_tabBarHeight;
@property(class, nonatomic, readonly) CGFloat xl_screenHeight;
@property(class, nonatomic, readonly) CGFloat xl_screenWidth;

#pragma mark ------ 系统时间
/**
 当前系统时间,格式化输出
 */
@property(class, nonatomic, readonly) NSString *xl_currentTime;
/**
 当前系统时间戳
 */
@property(class, nonatomic, readonly) NSString *xl_currentTimeZone;

#pragma mark ------ 沙盒目录文件

/**
 沙盒目录文件
 */
@property(class, nonatomic, readonly) NSString *xl_tempPath;
@property(class, nonatomic, readonly) NSString *xl_documentPath;
@property(class, nonatomic, readonly) NSString *xl_cachePath;

#pragma mark ------ 信号强度
/**
 信号强度
 */
@property(class, nonatomic, readonly) int xl_WifiStrength;

#pragma mark ------ 工具
/**
 显示文字在window
 */
+ (void)showTextOnWidow:(NSString *)text delay:(NSTimeInterval)dalay;

/**
 正则判断手机号码地址格式
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 判断字符串是否为空
 */
+ (BOOL)isEmptyString:(id)string;
/**
 判断是空null
 */
+ (BOOL)isEmptyClass:(id)emClass;

/**
 正则判断密码格式
 */
+ (BOOL)isPassword:(NSString *)password;

#pragma mark ------ 时间戳转换
/**
 时间戳转换时间
 */
+ (NSString *)timeTransFromTimestamp:(NSString *)stamp;

/**
 时间转换时间戳
 */
+ (NSString *)timestampFormTime:(NSString *)time;

/**
 时间戳转换时间(按固定格式:YYYY-MM-dd HH:mm:ss )
 */
+ (NSString *)timeTransFromTimestamp:(NSString *)stamp format:(NSString *)format;
#pragma mark ------ 字典/数组 转json
/**
 字典/数组 转json
 */
+ (NSString*)dictionaryToJson:(id)objc;
#pragma mark ------ UIImage
/**
 *  根据颜色生成一张图片
 *  @param color 提供的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark ------ UILabel

/**
 创建UILabel
 */
+ (UILabel *)labelWithTitle:(NSString *)title font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;


#pragma mark ------ UIImageView

/**
 生成二维码

 @param imageView 需要展示二维码的视图
 @param url 生成二维码的字符串
 */
+ (void)QRDroidImageView:(UIImageView *)imageView url:(NSString *)url size:(CGFloat)size Red:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

+ (void)QRDroidImageView:(UIImageView *)imageView url:(NSString *)url;
#pragma mark ------ 清理缓存文件
/**
 *
 *  获取path路径文件夹的大小
 *
 *  @param path 要获取大小的文件夹全路径
 *
 *  @return 返回path路径文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;

/**
 *
 *  清除path路径文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹全路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
@end
