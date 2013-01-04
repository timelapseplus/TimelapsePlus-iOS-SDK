//
//  TLPManager.h
//  Timelapse+ iOS SDK
//
//  Copyright (c) 2012-2013 Max Bäumle. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>

@protocol TLPManagerDelegate;
@class TLPDevice;

@interface TLPManager : NSObject

@property (weak, nonatomic) id <TLPManagerDelegate> delegate;
@property (readonly) CBCentralManagerState state;
@property (strong, nonatomic, readonly) NSArray *devices;

+ (instancetype)sharedManager;

- (void)scanForDevices;
- (void)stopScan;
- (void)connectDevice:(TLPDevice *)device;
- (void)cancelDeviceConnection:(TLPDevice *)device;

+ (NSString *)version;

@end

@protocol TLPManagerDelegate <NSObject>

@required

- (void)didUpdateState;

@optional

- (void)didDiscoverDevice;
- (void)didConnectDevice:(TLPDevice *)device;
- (void)didDisconnectDevice:(TLPDevice *)device error:(NSError *)error;
- (void)didFailToConnectDevice:(TLPDevice *)device error:(NSError *)error;

@end
