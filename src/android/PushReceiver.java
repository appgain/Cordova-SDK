package com.appgain.cordova.plugin;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;

import io.appgain.sdk.appcompat.controller.AppgainPushReceiver;
import io.appgain.sdk.appcompat.model.push.ReceiveStatus;


/**
 * Created by developers@appgain.io on 3/15/2018.
 */

public class PushReceiver extends AppgainPushReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);
    }

    @Override
    protected void onReceive(Context context, ReceiveStatus receiveStatus, Intent intent) {

    }

    @Override
    protected void onSilentPushReceive(@NonNull String operation) {
        super.onSilentPushReceive(operation);
    }
}