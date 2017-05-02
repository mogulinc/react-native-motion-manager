//
//  Gyroscope.m
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import <React/RCTBridge.h>
#import "RCTEventDispatcher.h"
#import "DeviceMotion.h"

@implementation DeviceMotion

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"DeviceMotion");

    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
        //Gyroscope
        if([self->_motionManager deviceMotionAvailable])
        {
            NSLog(@"DeviceMotion available");
            /* Start the gyroscope if it is not active already */
            if([self->_motionManager isDeviceMotionActive] == NO)
            {
                NSLog(@"DeviceMotion active");
            } else {
                NSLog(@"DeviceMotion not active");
            }
        }
        else
        {
            NSLog(@"DeviceMotion not Available!");
        }
    }
    return self;
}

RCT_EXPORT_METHOD(startDeviceMotionUpdates) {
    NSLog(@"startDeviceMotionUpdates");
    [self->_motionManager startDeviceMotionUpdates];

    /* Receive the gyroscope data on this block */
    [self->_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                      withHandler:^(CMDeviceMotion *deviceMotionData, NSError *error)
     {
         double roll = deviceMotionData.attitude.roll;
         double pitch = deviceMotionData.attitude.pitch;
         double yaw = deviceMotionData.attitude.yaw;
         double timestamp = deviceMotionData.timestamp;
         NSLog(@"startDeviceMotionUpdates: %f, %f, %f, %f", roll, pitch, yaw, timestamp);

         [self.bridge.eventDispatcher sendDeviceEventWithName:@"DeviceMotionData" body:@{
                                                                                 @"attitude": @{
                                                                                         @"roll" : [NSNumber numberWithDouble:roll],
                                                                                         @"pitch" : [NSNumber numberWithDouble:pitch],
                                                                                         @"yaw" : [NSNumber numberWithDouble:yaw],
                                                                                         @"timestamp" : [NSNumber numberWithDouble:timestamp]
                                                                                         }
                                                                                 }];
     }];

}

RCT_EXPORT_METHOD(stopDeviceMotionUpdates) {
    NSLog(@"stopDeviceMotionUpdates");
    [self->_motionManager stopDeviceMotionUpdates];
}

@end
