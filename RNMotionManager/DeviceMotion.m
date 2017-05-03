//
//  Gyroscope.m
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "DeviceMotion.h"

@implementation DeviceMotion

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[@"DeviceMotionData"];
}

- (id) init {
    self = [super init];
    NSLog(@"DeviceMotion");

    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
        //Device motion
        if([self->_motionManager isDeviceMotionAvailable])
        {
            NSLog(@"DeviceMotion available");
            /* Start the device motion if it is not active already */
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

    /* Receive the device motion data on this block */
    [self->_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                      withHandler:^(CMDeviceMotion *deviceMotionData, NSError *error)
     {
         double roll = deviceMotionData.attitude.roll;
         double pitch = deviceMotionData.attitude.pitch;
         double yaw = deviceMotionData.attitude.yaw;
         double timestamp = deviceMotionData.timestamp;
         NSLog(@"startDeviceMotionUpdates: %f, %f, %f, %f", roll, pitch, yaw, timestamp);

         [self sendEventWithName:@"DeviceMotionData" body:@{
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
