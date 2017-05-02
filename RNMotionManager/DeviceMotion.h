//
//  Accelerometer.h
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "RCTBridgeModule.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceMotion : NSObject <RCTBridgeModule> {
  CMMotionManager *_motionManager;
}
- (void) startDeviceMotionUpdates;
- (void) stopDeviceMotionUpdates;

@end
