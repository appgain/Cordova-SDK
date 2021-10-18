#import <Cordova/CDV.h>
#import <Appgain/Appgain.h>
@interface AppgainPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)initSDK:(CDVInvokedUrlCommand*)command;
- (void)getUserId:(CDVInvokedUrlCommand*)command;
- (void)matchLink:(CDVInvokedUrlCommand*)command;
- (void)fireAutomator:(CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)addPurchase:(CDVInvokedUrlCommand*)command;
- (void)addNotificationChannel:(CDVInvokedUrlCommand*)command;
- (void)updateUserData:(CDVInvokedUrlCommand*)command;
- (void)logEvent:(CDVInvokedUrlCommand*)command;
@end

@implementation AppgainPlugin
//CDVPluginResult* pluginResult ;

- (void)initSDK:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* apiKey = [args objectForKey:@"apiKey"];
    NSString* appid = [args objectForKey:@"appId"];
    BOOL config = (BOOL)[args objectForKey:@"autoConfigure"];

    [Appgain initialize:appid apiKey:apiKey trackUserForAdvertising:config whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}


- (void)getUserId:(CDVInvokedUrlCommand*)command
{
  
    CDVPluginResult  *   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: Appgain.getUserID];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)matchLink:(CDVInvokedUrlCommand*)command
{
    // Check command.arguments here.
          
        
   
    
    
    __block CDVPluginResult * pluginResult  = nil;
    [Appgain matchLink:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {

        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
    
    
}

- (void)fireAutomator:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* triggerPoint = [args objectForKey:@"triggerPointName"];
    NSMutableDictionary* payload = [args objectForKey:@"payload"];
    [Appgain fireAutomator:triggerPoint personalizationData:payload whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

- (void)setUserId:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* userId = [args objectForKey:@"id"];
    [Appgain updateUserId:userId whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
       
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

- (void)addPurchase:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* name = [args objectForKey:@"name"];
    double amount = [[args objectForKey:@"amount"] doubleValue];

    NSString* currency = [args objectForKey:@"currency"];

    [Appgain logPurchase:name withAmount:amount forCurrency:currency whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
 
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

- (void)addNotificationChannel:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* target = [args objectForKey:@"target"];

    NSString* type = [args objectForKey:@"type"];

    [Appgain createNotificationChannel:type withData:target whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
    
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

- (void)updateUserData:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSDictionary* data = [args objectForKey:@"userData"];

    [Appgain updateUserData:data whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
   
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}

- (void)logEvent:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult * pluginResult  = nil;
    NSDictionary *args = [command.arguments objectAtIndex:0];
    NSString* action = [args objectForKey:@"action"];
    NSString* event = [args objectForKey:@"event"];
    NSDictionary* extras = [args objectForKey:@"extras"];

    [Appgain logEvent:event andAction:action extras:extras whenFinish:^(NSURLResponse *response, NSMutableDictionary *result, NSError *error) {
    
        if(result != nil){
            NSString* info = [NSString stringWithFormat:@"%@", result];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: info];
        }
        else if (error != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];

        }
        else if (response != nil){
            // Call failure callback
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:response.debugDescription];

        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }];
}
@end


