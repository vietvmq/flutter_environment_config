#import <Flutter/Flutter.h>

@interface FlutterEnvConfigPlugin : NSObject<FlutterPlugin>
+ (NSDictionary *)env;
+ (NSString *)envFor: (NSString *)key;
@end
