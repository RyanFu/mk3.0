//
//  SDiOSVersion.h
//  SDVersion
//
//  Copyright (c) 2016 Sebastian Dobrincu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

typedef NS_ENUM(NSInteger, DeviceVersion){
    iPhone4           = 3,
    iPhone4S          = 4,
    iPhone5           = 5,
    iPhone5C          = 6,
    iPhone5S          = 7,
    iPhone6           = 8,
    iPhone6Plus       = 9,
    iPhone6S          = 10,
    iPhone6SPlus      = 11,
    iPhoneSE          = 12,
    iPhone7           = 13,
    iPhone7Plus       = 14,

    iPad1             = 20,
    iPad2             = 21,
    iPadMini          = 22,
    iPad3             = 23,
    iPad4             = 24,
    iPadAir           = 25,
    iPadMini2         = 26,
    iPadAir2          = 27,
    iPadMini3         = 28,
    iPadMini4         = 29,
    iPadPro12Dot9Inch = 30,
    iPadPro9Dot7Inch  = 31,
    
    iPodTouch1Gen     = 50,
    iPodTouch2Gen     = 51,
    iPodTouch3Gen     = 52,
    iPodTouch4Gen     = 53,
    iPodTouch5Gen     = 54,
    iPodTouch6Gen     = 55,
    
    Simulator         =  0
};

static NSString *DeviceVersionNames[] = {
    [iPhone4]           = @"iPhone 4",
    [iPhone4S]          = @"iPhone 4S",
    [iPhone5]           = @"iPhone 5",
    [iPhone5C]          = @"iPhone 5C",
    [iPhone5S]          = @"iPhone 5S",
    [iPhone6]           = @"iPhone 6",
    [iPhone6Plus]       = @"iPhone 6 Plus",
    [iPhone6S]          = @"iPhone 6S",
    [iPhone6SPlus]      = @"iPhone 6S Plus",
    [iPhone7]           = @"iPhone7",
    [iPhone7Plus]       = @"iPhone7 Plus",
    
    [iPhoneSE]          = @"iPhone SE",
    
    [iPad1]             = @"iPad 1",
    [iPad2]             = @"iPad 2",
    [iPadMini]          = @"iPad Mini",
    [iPad3]             = @"iPad 3",
    [iPad4]             = @"iPad 4",
    [iPadAir]           = @"iPad Air",
    [iPadMini2]         = @"iPad Mini 2",
    [iPadAir2]          = @"iPad Air 2",
    [iPadMini3]         = @"iPad Mini 3",
    [iPadMini4]         = @"iPad Mini 4",
    [iPadPro9Dot7Inch]  = @"iPad Pro",
    [iPadPro12Dot9Inch] = @"iPad Pro",
    
    [iPodTouch1Gen]     = @"iPod Touch 1st Gen",
    [iPodTouch2Gen]     = @"iPod Touch 2nd Gen",
    [iPodTouch3Gen]     = @"iPod Touch 3rd Gen",
    [iPodTouch4Gen]     = @"iPod Touch 4th Gen",
    [iPodTouch5Gen]     = @"iPod Touch 5th Gen",
    [iPodTouch6Gen]     = @"iPod Touch 6th Gen",
    
    [Simulator]         = @"Simulator"
};

typedef NS_ENUM(NSInteger, DeviceSize){
    UnknownSize     = 0,
    Screen3Dot5inch = 1,
    Screen4inch     = 2,
    Screen4Dot7inch = 3,
    Screen5Dot5inch = 4
};

static NSString *DeviceSizeNames[] = {
    [UnknownSize]     = @"Unknown Size",
    [Screen3Dot5inch] = @"3.5 inch",
    [Screen4inch]     = @"4 inch",
    [Screen4Dot7inch] = @"4.7 inch",
    [Screen5Dot5inch] = @"5.5 inch"
};

@interface GetDeviceName : NSObject

#define iOSVersionEqualTo(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define iOSVersionGreaterThan(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define iOSVersionGreaterThanOrEqualTo(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOSVersionLessThan(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define iOSVersionLessThanOrEqualTo(v)        ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

+ (DeviceVersion)deviceVersion;
+ (DeviceSize)resolutionSize;
+ (DeviceSize)deviceSize;
+ (NSString*)deviceName;
+ (BOOL)isZoomed;

@end
