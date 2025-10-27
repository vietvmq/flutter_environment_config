#import <Flutter/Flutter.h>

@interface FlutterEnvironmentConfigPlugin : NSObject<FlutterPlugin>
+ (NSDictionary *)env;
+ (NSString *)envFor: (NSString *)key;
@end
