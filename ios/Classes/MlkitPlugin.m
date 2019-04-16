#import "MlkitPlugin.h"
#import "Firebase/Firebase.h"

@implementation MlkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"plugins.flutter.io/mlkit"
                                     binaryMessenger:[registrar messenger]];
    MlkitPlugin* instance = [[MlkitPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![FIRApp defaultApp]) {
            [FIRApp configure];
        }
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method hasSuffix:@"identifyLanguage"]) {
        FIRNaturalLanguage *naturalLanguage = [FIRNaturalLanguage naturalLanguage];
        FIRLanguageIdentification *languageId = [naturalLanguage languageIdentification];

        [languageId identifyLanguageForText: call.arguments[@"text"]
                         completion:^(NSString* languageCode,
                                      NSError* error) {
            result(languageCode);
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
