#import "FlutterEnvConfigPlugin.h"
#import "GeneratedDotEnv.m" // written during build by BuildDotenvConfig.ruby

@implementation FlutterEnvConfigPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_env_config"
            binaryMessenger:[registrar messenger]];
  FlutterEnvConfigPlugin* instance = [[FlutterEnvConfigPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

+ (NSDictionary *)env {
    return (NSDictionary *)DOT_ENV;
}

+ (NSString *)envFor: (NSString *)key {
    NSString *value = (NSString *)[self.env objectForKey:key];
    return value;
}

- (NSDictionary *)constantsToExport {
    return DOT_ENV
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"loadEnvVariables" isEqualToString:call.method]) {
      NSDictionary *variables = (NSDictionary *)DOT_ENV;
      
      result(variables);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
