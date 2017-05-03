//
//  Accelerometer.h
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "RCTEventEmitter.h"
#import "RCTBridgeModule.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceMotion : RCTEventEmitter <RCTBridgeModule> {
  CMMotionManager *_motionManager;
}
- (void) startDeviceMotionUpdates;
- (void) stopDeviceMotionUpdates;

@end
