package com.pamakids.zhuge;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created by Administrator on 2015/5/13.
 */
public class ZhugeAnalytics implements FREExtension {

    private static final String TAG = "ZhugeAnalytics";

    @Override
    public void initialize() {
        Log.d(TAG, "initialize()!");
    }

    @Override
    public FREContext createContext(String s) {
        Log.d(TAG, "createContext()");
        return new ZhugeAnalyticsContext();
    }

    @Override
    public void dispose() {
        Log.d(TAG, "dispose()!");
    }
}
