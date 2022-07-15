#import "AppManagementPlugin.h"
#if __has_include(<app_management/app_management-Swift.h>)
#import <app_management/app_management-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_management-Swift.h"
#endif

@implementation AppManagementPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppManagementPlugin registerWithRegistrar:registrar];
}
@end
