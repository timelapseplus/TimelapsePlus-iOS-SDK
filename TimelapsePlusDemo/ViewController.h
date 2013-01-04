//
//  ViewController.h
//  Timelapse+ iOS Demo
//
//  Copyright (c) 2012-2013 Max Bäumle. All rights reserved.
//

#import <TimelapsePlus/TimelapsePlus.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIButton *stopScanButton;

@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

@property (weak, nonatomic) IBOutlet UIButton *requestBatteryButton;
@property (weak, nonatomic) IBOutlet UIButton *setCaptureButton;

- (IBAction)scan:(UIButton *)sender;
- (IBAction)stopScan:(UIButton *)sender;

- (IBAction)connect:(UIButton *)sender;
- (IBAction)disconnect:(UIButton *)sender;

- (IBAction)requestBattery:(UIButton *)sender;
- (IBAction)setCapture:(UIButton *)sender;

@end
