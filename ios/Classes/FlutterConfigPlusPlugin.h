#import <Flutter/Flutter.h>

@interface FlutterConfigPlusPlugin : NSObject<FlutterPlugin>
+ (NSDictionary *)env;
+ (NSString *)envFor: (NSString *)key;
@end
