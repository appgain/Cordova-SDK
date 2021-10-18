import Appgain
import Foundation
@objc(AppgainPlugin) class AppgainPlugin : CDVPlugin{
// MARK: Properties
var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
  //parameter :-
// appId (String)
// apiKey (String)
// configure (Bool)
// Output : -  callback with two parameter
  ///   response  as string
  ///    info dictionary
@objc(initSDK:) func initSDK(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    let param1 = command.arguments[0]  as? String
    let param2 = command.arguments[1] as? String
    let param3 = command.arguments[1]  as? String
    if let p1 = param1 , let p2 = param2 , let p3 = param3 {
        Appgain.initialize(p1, apiKey: p2, trackUserForAdvertising: p3) { (response, info, error) in
             if info != nil {
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: info)
                  }
            else{
                 pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
                  }
                }

    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}

@objc(getUserId:) func getUserId(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
    
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: Appgain.getUserID())
            self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)

}
@objc(matchLink:) func matchLink(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
      Appgain.matchLink { (response, info, error) in
        if info != nil {
             pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: info)
        }
         else{
            pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
         }
    }
        self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)

}


// @objc(fireAutomatorWithPersonalization:) func fireAutomatorWithPersonalization(_ command: CDVInvokedUrlCommand) {
//     var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

//        let triggerPoint = command.arguments[0]  as? String
//     let personalizeData = command.arguments[1] as? Dictionary
//     if let p1 = triggerPoint , let p2 = personalizeData {
//          Appgain.fireAutomator(p1, personalizationData: p2 ) { (response, info, error) in
//              if info != nil {
//                 pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: info)
//                   }
//             else{
//                  pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
//                   }
//                 }

//     }else {
//           pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
//     }
//     self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
// }

@objc(fireAutomator:) func fireAutomator(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

       let args = command.arguments[0]  as? Dictionary
       
    if let data = args {
        let  triggerPoint = data["triggerPointName"] as? String
        let payload = data["payload"] as? Dictionary
         Appgain.fireAutomator(triggerPoint ?? "", personalizationData: payload ) { (response, info, error) in
             if info != nil {
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: info)
                  }
            else{
                 pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
                  }
                }

    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}
@objc(setUserId:) func setUserId(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

       let args = command.arguments[0]  as? Dictionary
    if let p1 = args?["id"] as? String{

         Appgain.updateUserId(p1)
         pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "userID updated")
    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}
//productName (String)
//currency (String)
//amount (String)
@objc(addPurchase:) func addPurchase(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

 let args = command.arguments[0]  as? Dictionary
    if let data = args{
         let productName = data["name"]  as? String
              let currency = data["amount"] as? String
       let amount = String((data["currency"]  as? Double) ?? 0)

         Appgain.logPurchase(productName ?? "", withAmount: p2 ?? "", forCurrency: currency ?? "") { (response, info, error) in
  
             if info != nil {
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: info)
                  }
            else{
                 pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.debugDescription)
                  }
                }

    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}
// @objc(enableReciveNotification:) func enableReciveNotification(_ command: CDVInvokedUrlCommand) {
//     var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

//        let enable = command.arguments[0]  as? Bool
//               let type = command.arguments[1]  as? String

//     if let p1 = enable, let p2 = currency{
//                  Appgain.enableNotifications(p, forType: type)
//                 pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "operation Done")
          

//     }else {
//           pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
//     }
//     self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
// }
//item (String)
//notificationType
@objc(addNotificationChannel:) func addNotificationChannel(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)
 let args = command.arguments[0]  as? Dictionary
    if let data = args{
        let item = data["target"]  as? String
              let type = data["type"]  as? String
          Appgain.createNotificationChannel(type ?? "", withData: item ?? "")
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "operation Done")
    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}

@objc(updateUserData:) func updateUserData(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

       let item = command.arguments[0]  as? Dictionary

    if let p1 = item["userData"] as? Dictionary{
                Appgain.updateUserData(p1)
                pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "operation Done")
          

    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}
//MARK: log event
 //action;
// event;
// extras;
@objc(logEvent:) func logEvent(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)


     let args = command.arguments[0]  as? Dictionary
    if let data = args{
               let type = data["action"]  as? String
    let action = data["event"]  as? String
    let extra = data["extras"]  as? Dictionary
        Appgain.logEvent(type ?? "", andAction: action ?? "", extras: extra ?? [:])             
           pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "operation Done")
        
    }else {
          pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "missing parameters")
 
    }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
}
}

//func names
// initSDK
// getUserID
// createSmartLink
// createLandingPage
// fireAutomatorWithPersonalization
// fireAutomator
// setuserId
// addPurchase
// enableReciveNotification
// addNotificationChannel
// updateUser
// logEvent