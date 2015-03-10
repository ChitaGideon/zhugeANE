package com.pamakids.umeng.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import com.umeng.analytics.MobclickAgent;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM11:03
 * To change this template use File | Settings | File Templates.
 */
public class BeginLogPageViewFunction implements FREFunction {

    public static final String TAG = "BeginLogPageViewFunction";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

      String name = null;
       try {
            name = args[0].getAsString();
        } catch (Exception e) {
            Log.e(TAG, "GetEventID:" + e.toString());
        }
        MobclickAgent.onPageStart(name);
        Log.d(TAG, "beginLogPageView");

        return null;
    }

}
