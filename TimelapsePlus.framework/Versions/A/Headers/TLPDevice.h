//
//  TLPDevice.h
//  Timelapse+ iOS SDK
//
//  Copyright (c) 2012-2013 Max Bäumle. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <Foundation/Foundation.h>
#import <TimelapsePlus/TLPDefines.h>

@protocol TLPDeviceDelegate;

@interface TLPDevice : NSObject

@property (strong, nonatomic, readonly) CBPeripheral *peripheral;
@property (weak, nonatomic) id <TLPDeviceDelegate> delegate;
@property (readonly, getter = isOpen) BOOL open;

@property (readonly) uint8_t battery;
@property (readonly) unsigned long firmware;
@property (readonly) uint8_t BTFWVersion;
@property (readonly) unsigned long protocolVersion;
@property (readonly) TLPCameraFPS cameraFPS;
@property (readonly) TLPCameraMake cameraMake;

- (id)init NS_UNAVAILABLE;
- (id)initWithPeripheral:(CBPeripheral *)peripheral;

- (void)open;
- (void)close;

- (void)sendData:(NSData *)data;
- (void)sendData:(NSData *)data dataId:(TLPDataId)dataId dataType:(TLPDataType)dataType;
- (void)sendDataId:(TLPDataId)dataId dataType:(TLPDataType)dataType;

@end

@protocol TLPDeviceDelegate <NSObject>

@required

- (void)deviceDidChangeOpenState:(TLPDevice *)device;

@optional

- (void)device:(TLPDevice *)device didReceiveData:(NSData *)data;
- (void)device:(TLPDevice *)device didReceiveData:(NSData *)data dataId:(TLPDataId)dataId dataType:(TLPDataType)dataType;
- (void)device:(TLPDevice *)device didReceiveDataId:(TLPDataId)dataId dataType:(TLPDataType)dataType;

@end
