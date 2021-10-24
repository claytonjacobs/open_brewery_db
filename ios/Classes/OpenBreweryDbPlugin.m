#import "OpenBreweryDbPlugin.h"
#if __has_include(<open_brewery_db/open_brewery_db-Swift.h>)
#import <open_brewery_db/open_brewery_db-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "open_brewery_db-Swift.h"
#endif

@implementation OpenBreweryDbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpenBreweryDbPlugin registerWithRegistrar:registrar];
}
@end
