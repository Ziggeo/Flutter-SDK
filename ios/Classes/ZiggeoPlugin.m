#import "ZiggeoPlugin.h"
#if __has_include(<ziggeo/ziggeo-Swift.h>)
#import <ziggeo/ziggeo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ziggeo-Swift.h"
#endif

@implementation ZiggeoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZiggeoPlugin registerWithRegistrar:registrar];
}
@end
