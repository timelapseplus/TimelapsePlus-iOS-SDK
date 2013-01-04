//
//  TLPDefines.h
//  Timelapse+ iOS SDK
//
//  Copyright (c) 2012-2013 Max Bäumle. All rights reserved.
//

// bluetooth.h
#define BT_BUF_SIZE 128

// IR.h
#define CANON 0
#define NIKON 1
#define SONY 2
#define MINOLTA 3
#define OLYMPUS 4
#define PENTAX 5
#define PANASONIC 6
#define OTHER 100

// remote.h
#define REMOTE_STATUS 1
#define REMOTE_PROGRAM 2
#define REMOTE_START 3
#define REMOTE_STOP 4
#define REMOTE_BATTERY 5
#define REMOTE_BULB_START 6
#define REMOTE_BULB_END 7
#define REMOTE_CAPTURE 8

#define REMOTE_FIRMWARE 11
#define REMOTE_BT_FW_VERSION 12
#define REMOTE_PROTOCOL_VERSION 13
#define REMOTE_CAMERA_FPS 14
#define REMOTE_CAMERA_MAKE 15

#define REMOTE_TYPE_SEND 0
#define REMOTE_TYPE_REQUEST 1
#define REMOTE_TYPE_SET 2
#define REMOTE_TYPE_NOTIFY_SET 3
#define REMOTE_TYPE_NOTIFY_UNSET 4

typedef NS_ENUM(uint8_t, TLPDataId) {
    TLPDataIdStatus = REMOTE_STATUS,
    TLPDataIdProgram = REMOTE_PROGRAM,
    TLPDataIdStart = REMOTE_START,
    TLPDataIdStop = REMOTE_STOP,
    TLPDataIdBattery = REMOTE_BATTERY,
    TLPDataIdBulbStart = REMOTE_BULB_START,
    TLPDataIdBulbEnd = REMOTE_BULB_END,
    TLPDataIdCapture = REMOTE_CAPTURE,
    TLPDataIdFirmware = REMOTE_FIRMWARE,
    TLPDataIdBTFWVersion = REMOTE_BT_FW_VERSION,
    TLPDataIdProtocolVersion = REMOTE_PROTOCOL_VERSION,
    TLPDataIdCameraFPS = REMOTE_CAMERA_FPS,
    TLPDataIdCameraMake = REMOTE_CAMERA_MAKE
};

typedef NS_ENUM(uint8_t, TLPDataType) {
    TLPDataTypeSend = REMOTE_TYPE_SEND,
    TLPDataTypeRequest = REMOTE_TYPE_REQUEST,
    TLPDataTypeSet = REMOTE_TYPE_SET,
    TLPDataTypeNotifySet = REMOTE_TYPE_NOTIFY_SET,
    TLPDataTypeNotifyUnset = REMOTE_TYPE_NOTIFY_UNSET
};

// Menu_Map.h
typedef NS_ENUM(uint8_t, TLPCameraFPS) {
    TLPCameraFPS12 = 8,
    TLPCameraFPS10 = 10,
    TLPCameraFPS8 = 12,
    TLPCameraFPS7 = 14,
    TLPCameraFPS6 = 16,
    TLPCameraFPS5 = 20,
    TLPCameraFPS4 = 25,
    TLPCameraFPS3 = 33,
    TLPCameraFPS2 = 50,
    TLPCameraFPS1 = 100
};

typedef NS_ENUM(uint8_t, TLPCameraMake) {
    TLPCameraMakeCanon = CANON,
    TLPCameraMakeNikon = NIKON,
    TLPCameraMakeSony = SONY,
    TLPCameraMakeMinolta = MINOLTA,
    TLPCameraMakeOlympus = OLYMPUS,
    TLPCameraMakePentax = PENTAX,
    TLPCameraMakePanasonic = PANASONIC,
    TLPCameraMakeOther = OTHER
};
