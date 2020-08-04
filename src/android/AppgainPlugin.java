package com.appgain.cordova.plugin;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import android.support.annotation.Nullable;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import io.appgain.sdk.appcompat.controller.Appgain;
import io.appgain.sdk.appcompat.interfaces.AppgainDataCallback;
import io.appgain.sdk.appcompat.model.BaseResponse;
import io.appgain.sdk.appcompat.model.deferredlinking.DeferredDeepLinkingResponse;

public class AppgainPlugin extends CordovaPlugin {

    private static Gson gson = new GsonBuilder().create();
    private boolean isInitialized = false;

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        Log.e("execute", "action = " + action);
        Appgain.enableLog();
        switch(action) {
            case "initSDK":
                initSDK(args, callbackContext);
                break;
            case "initUser":
                initUser(args, callbackContext);
                break;
            case "matchLink":
                matchLink(args, callbackContext);
                break;
            case "fireAutomator":
                fireAutomator(args, callbackContext);
                break;
            case "addPurchase":
                addPurchase(args, callbackContext);
                break;
            case "addNotificationChannel":
                addNotificationChannel(args, callbackContext);
                break;
            case "logEvent":
                logEvent(args, callbackContext);
                break;
            case "getUserId":
                getUserId(args, callbackContext);
                break;
            case "setUserId":
                setUserId(args, callbackContext);
                break;
            case "updateUserData":
                updateUserData(args, callbackContext);
                break;
            default:
                Log.e("execute", "action is not implemented");
                Exception exception = new RuntimeException(action + "() is not implemented");
                callbackContext.error(gson.toJson(exception));
                return false;

        }
        return true;
    }

    private void setUserId(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            String id = options.optString("id");
            if(!id.isEmpty()){
                Appgain.updateUserId(id, new AppgainDataCallback<String>() {
                    @Override
                    public void onSuccess(String data) {
                        callbackContext.success(gson.toJson(""));

                    }

                    @Override
                    public void onFailure(BaseResponse failure) {
                        callbackContext.error(gson.toJson(failure));
                    }
                });
            }
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }

    }

    private void getUserId(JSONArray args, CallbackContext callbackContext) {
        try {
            String userId = Appgain.getUserId();
            JSONObject result = new JSONObject();
            result.put("userId", userId);
            callbackContext.success(result);
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    public static Bundle jsonToBundle(@Nullable JSONObject jsonObject) {
        Bundle bundle = new Bundle();
        if(jsonObject != null){
            Iterator iter = jsonObject.keys();
            while(iter.hasNext()){
                try {
                    String key = (String)iter.next();
                    String value = jsonObject.getString(key);
                    bundle.putString(key,value);
                }catch (Exception e){ }
            }
        }
        return bundle;
    }

    public static Map<String, String> jsonTotoMap(@Nullable JSONObject jsonobj) {
        Map<String, String> map = new HashMap<String, String>();
        if(jsonobj != null){
            Iterator<String> keys = jsonobj.keys();
            while(keys.hasNext()) {
                String key = keys.next();
                Object value = jsonobj.opt(key);
                if(value != null){
                    if (value instanceof JSONArray) {
                        value = jsonToList((JSONArray) value);
                    } else if (value instanceof JSONObject) {
                        value = jsonTotoMap((JSONObject) value);
                    }
                    map.put(key, value.toString());
                }
            }
        }
        return map;
    }

    public static List<String> jsonToList(JSONArray array) {
        List<String> list = new ArrayList<String>();
        if(array != null){
            for (int i = 0; i < array.length(); i++) {
                Object value = array.opt(i);
                if(value != null){
                    if (value instanceof JSONArray) {
                        value = jsonToList((JSONArray) value);
                    } else if (value instanceof JSONObject) {
                        value = jsonTotoMap((JSONObject) value);
                    }
                    list.add(value.toString());
                }
            }
        }
        return list;
    }

    private void logEvent(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            String action = options.optString("action");
            String event = options.optString("event");
            JSONObject extras = options.optJSONObject("extras");
            Appgain.logEvent(event, action, jsonToBundle(extras), new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void updateUserData(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            JSONObject userData = options.optJSONObject("userData");
            Appgain.updateUserData(jsonTotoMap(userData), new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void addNotificationChannel(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            String type = options.optString("type");
            String target = options.optString("target");
            Appgain.createNotificationChannel(type, target, new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void addPurchase(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            String name = options.optString("name");
            String currency = options.optString("currency");
            double amount = options.optDouble("amount");
            Appgain.logPurchase(name, (float) amount, currency, new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void matchLink(JSONArray args, CallbackContext callbackContext) {
        try {
            Appgain.matchLink(new AppgainDataCallback<DeferredDeepLinkingResponse>() {
                @Override
                public void onSuccess(DeferredDeepLinkingResponse data) {
                    callbackContext.success(gson.toJson(data));

                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void initUser(JSONArray args, CallbackContext callbackContext) {
        try {
            if(isInitialized){
                callbackContext.success(gson.toJson(""));
            }else{
                Exception exception = new RuntimeException("please call initSDK first");
                callbackContext.error(gson.toJson(exception));
            }
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }

    private void initSDK(JSONArray args, CallbackContext callbackContext) {
        try {
            Log.e("initSDK", "start");
            JSONObject options = args.getJSONObject(0);
            String appId = options.optString("appId");
            String apiKey = options.optString("apiKey");
            boolean config = options.optBoolean("autoConfigure");
            Context context = this.cordova.getActivity().getApplicationContext();
            Log.e("initSDK", "appId: " + appId);
            Log.e("initSDK", "apiKey: " + apiKey);
            Log.e("initSDK", "config: " + config);
            Log.e("initSDK", "context: " + context);

            Appgain.initialize(context, appId, apiKey, config, new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    Log.e("initSDK", "onSuccess");
                    isInitialized = true;
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    Log.e("initSDK", "onFailure");
                    callbackContext.error(gson.toJson(failure));
                }
            });
        } catch (Exception e) {
            Log.e("initSDK", e.getMessage());
            callbackContext.error(gson.toJson(e));
        }
    }

    private void fireAutomator(JSONArray args, CallbackContext callbackContext) {
        try {
            JSONObject options = args.getJSONObject(0);
            String triggerPointName = options.optString("triggerPointName");
            JSONObject payload = options.optJSONObject("payload");
            Appgain.fireAutomator(triggerPointName, jsonTotoMap(payload), new AppgainDataCallback<Void>() {
                @Override
                public void onSuccess(Void data) {
                    callbackContext.success(gson.toJson(""));
                }

                @Override
                public void onFailure(BaseResponse failure) {
                    callbackContext.error(gson.toJson(failure));

                }
            });
        } catch (Exception e) {
            callbackContext.error(gson.toJson(e));
        }
    }


}