function AppgainPlugin() {}

// The function that passes work along to native shells
// Message is a string, duration may be 'long' or 'short'
AppgainPlugin.prototype.initSDK = function (appId, apiKey, autoConfigure) {
  var options = {};
  options.appId = appId;
  options.apiKey = apiKey;
  options.autoConfigure = autoConfigure;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "initSDK", [options]);
  });
};

// let initSDK = (appId, apiKey, autoConfigure) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.initAppgainSDK(
//       appId,
//       apiKey,
//       autoConfigure,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.initUser = function (email, password, username) {
  var options = {};
  options.email = email;
  options.password = password;
  options.username = username;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "initUser", [options]);
  });
};

// let matchLink = () => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.matchLink(
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.matchLink = function () {
  var options = {};
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "matchLink", [options]);
  });
};

AppgainPlugin.prototype.fireAutomator = function (triggerPointName, payload) {
  var options = {};
  options.triggerPointName = triggerPointName;
  options.payload = payload;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "fireAutomator", [options]);
  });
};

// let fireAutomator = ({ triggerPointName, payload = {} }) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.fireAutomatorWithPersonalization(
//       triggerPointName,
//       payload,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.addPurchase = function (name, amount, currency) {
  var options = {};
  options.name = name;
  options.amount = amount;
  options.currency = currency;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "addPurchase", [options]);
  });
};

// let addPurchase = (name, amount, currency) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.addPurchase(
//       name,
//       amount,
//       currency,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.addNotificationChannel = function (type, target) {
  var options = {};
  options.type = type;
  options.target = target;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "addNotificationChannel", [
      options,
    ]);
  });
};

// let addNotificationChannel = (type, target) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.addNotificationChannel(
//       type,
//       target,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.logEvent = function (event, action, extras) {
  var options = {};
  options.action = action;
  options.event = event;
  options.extras = extras;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "logEvent", [options]);
  });
};

// let logEvent = (action, type, extras) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.logEvent(
//       action,
//       type,
//       extras,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.getUserId = function () {
  var options = {};
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "getUserId", [options]);
  });
};

// let getUserId = () => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.getuserId(
//       (id) => resolve(id),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.setUserId = function (id) {
  var options = {};
  options.id = id;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "setUserId", [options]);
  });
};

// let setUserId = (id) => {
//   return new Promise((resolve, reject) => {
//     AppgainSDK.setuserId(
//       id,
//       () => resolve(),
//       (err) => reject(err)
//     );
//   });
// };

AppgainPlugin.prototype.updateUserData = function (userData) {
  var options = {};
  options.userData = userData;
  return new Promise((resolve, reject) => {
    cordova.exec(resolve, reject, "AppgainPlugin", "updateUserData", [options]);
  });
};

// Installation constructor that binds AppgainPlugin to window
AppgainPlugin.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }
  window.plugins.AppgainPlugin = new AppgainPlugin();
  return window.plugins.AppgainPlugin;
};
cordova.addConstructor(AppgainPlugin.install);
