//
//  ViewController.m
//  Timelapse+ iOS Demo
//
//  Copyright (c) 2012-2013 Max Bäumle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <TLPManagerDelegate, TLPDeviceDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"%@", [TLPManager version]);
    
    [TLPManager sharedManager].delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scan:(UIButton *)sender {
    self.scanButton.alpha = 0.5f;
    self.scanButton.enabled = NO;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[TLPManager sharedManager] scanForDevices];
    
    self.stopScanButton.alpha = 1.0f;
    self.stopScanButton.enabled = YES;
    
    [self reloadTableViewData];
}

- (IBAction)stopScan:(UIButton *)sender {
    self.stopScanButton.alpha = 0.5f;
    self.stopScanButton.enabled = NO;
    
    [[TLPManager sharedManager] stopScan];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.scanButton.alpha = 1.0f;
    self.scanButton.enabled = YES;
}

- (IBAction)connect:(UIButton *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath) {
        self.stopScanButton.alpha = 0.5f;
        self.stopScanButton.enabled = NO;
        
        [[TLPManager sharedManager] stopScan];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        self.scanButton.alpha = 1.0f;
        self.scanButton.enabled = YES;
        
        TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
        [[TLPManager sharedManager] connectDevice:device];
    }
    
    self.connectButton.alpha = 0.5f;
    self.connectButton.enabled = NO;
}

- (IBAction)disconnect:(UIButton *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath) {
        TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
        [[TLPManager sharedManager] cancelDeviceConnection:device];
    }
    
    self.disconnectButton.alpha = 0.5f;
    self.disconnectButton.enabled = NO;
}

- (IBAction)requestBattery:(UIButton *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath) {
        TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
        [device sendDataId:TLPDataIdBattery dataType:TLPDataTypeRequest];
    }
}

- (IBAction)setCapture:(UIButton *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath) {
        TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
        [device sendDataId:TLPDataIdCapture dataType:TLPDataTypeSet];
    }
}

- (void)reloadTableViewData {
    self.connectButton.alpha = 0.5f;
    self.connectButton.enabled = NO;
    
    self.disconnectButton.alpha = 0.5f;
    self.disconnectButton.enabled = NO;
    
    self.requestBatteryButton.alpha = 0.5f;
    self.requestBatteryButton.enabled = NO;
    
    self.setCaptureButton.alpha = 0.5f;
    self.setCaptureButton.enabled = NO;
    
    [self.tableView reloadData];
}

#pragma mark - Manager delegate

- (void)didUpdateState {
    if ([TLPManager sharedManager].state == CBCentralManagerStatePoweredOn) {
        self.scanButton.alpha = 1.0f;
        self.scanButton.enabled = YES;
    } else {
        self.scanButton.alpha = 0.5f;
        self.scanButton.enabled = NO;
        
        self.stopScanButton.alpha = 0.5f;
        self.stopScanButton.enabled = NO;
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    [self reloadTableViewData];
}

- (void)didDiscoverDevice {
    [self reloadTableViewData];
}

- (void)didConnectDevice:(TLPDevice *)device {
    device.delegate = self;
    [device open];
    
    [self reloadTableViewData];
}

- (void)didDisconnectDevice:(TLPDevice *)device error:(NSError *)error {
    device.delegate = nil;
    [device close];
    
    [self reloadTableViewData];
}

- (void)didFailToConnectDevice:(TLPDevice *)device error:(NSError *)error {
    TLPDevice *selectedDevice = [[TLPManager sharedManager].devices objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    
    if (selectedDevice == device) {
        self.connectButton.alpha = 1.0f;
        self.connectButton.enabled = YES;
    }
}

#pragma mark - Device delegate

- (void)deviceDidChangeOpenState:(TLPDevice *)device {
    [self reloadTableViewData];
}

- (void)device:(TLPDevice *)device didReceiveData:(NSData *)data dataId:(TLPDataId)dataId dataType:(TLPDataType)dataType {
    switch (dataId) {
        case TLPDataIdBattery:
            if (dataType == TLPDataTypeSend) {
                [self reloadTableViewData];
            }
            
            break;
        
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TLPManager sharedManager].devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = device.peripheral;
    
    if (device.open) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else if (peripheral.isConnected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorView startAnimating];
        
        cell.accessoryView = activityIndicatorView;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    
    cell.textLabel.text = peripheral.name;
    
    if (device.battery) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%hhu %%", device.battery];
    } else {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TLPDevice *device = [[TLPManager sharedManager].devices objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = device.peripheral;
    
    if (peripheral.isConnected) {
        self.connectButton.alpha = 0.5f;
        self.connectButton.enabled = NO;
        
        self.disconnectButton.alpha = 1.0f;
        self.disconnectButton.enabled = YES;
        
        if (device.open) {
            self.requestBatteryButton.alpha = 1.0f;
            self.requestBatteryButton.enabled = YES;
            
            self.setCaptureButton.alpha = 1.0f;
            self.setCaptureButton.enabled = YES;
        }
    } else {
        self.connectButton.alpha = 1.0f;
        self.connectButton.enabled = YES;
        
        self.disconnectButton.alpha = 0.5f;
        self.disconnectButton.enabled = NO;
        
        self.requestBatteryButton.alpha = 0.5f;
        self.requestBatteryButton.enabled = NO;
        
        self.setCaptureButton.alpha = 0.5f;
        self.setCaptureButton.enabled = NO;
    }
}

@end
