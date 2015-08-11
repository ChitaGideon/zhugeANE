package com.pamakids.zhuge;

import android.util.Log;
import com.adobe.fre.*;
import com.zhuge.analysis.stat.ZhugeSDK;
import com.zhuge.push.msg.ZGPush;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/5/13.
 */
public class ZhugeAnalyticsContext extends FREContext {

    private static final String TAG = "ZHUGE";

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> map = new HashMap<String, FREFunction>();
        map.put("startAnaly", new StartAnaly());
        map.put("onEvent", new OnEvent());
        map.put("identify", new Identify());
        map.put("initPushService", new InitPushService());
        return map;
    }

    @Override
    public void dispose() {
//        ZhugeSDK.getInstance().flush(this.getActivity().getApplicationContext());
    }

//    private boolean _isDebug;

    void startAnaly(String appkey, String channelID, String version, Boolean isDebug){
//        _isDebug = isDebug;
        Log.d(TAG, "ZhugeSDK init!!");
//        ZhugeSDK.getInstance().init(this.getActivity().getApplicationContext(), appkey, channelID);
        ZhugeSDK.getInstance().init(this.getActivity().getApplicationContext());
    }

    void onEvent(String eventID, String label){
        Log.d(TAG, "onEvent called!");
        JSONTokener jsonTokener = new JSONTokener(label);
        JSONObject jsonObject = null;
        try {
            jsonObject = (JSONObject) jsonTokener.nextValue();
            Log.d(TAG, "json解析完成！");
            	
        } catch (JSONException e) {
            Log.d(TAG, "json解析出错");
            e.printStackTrace();
            return;
        }
        ZhugeSDK.getInstance().onEvent(this.getActivity().getApplicationContext(), eventID, jsonObject);
    }

    void identify(String uId, String label){
        Log.d(TAG, "identify called!");
        JSONTokener jsonTokener = new JSONTokener(label);
        JSONObject jsonObject = null;
        try {
            jsonObject = (JSONObject) jsonTokener.nextValue();
            Log.d(TAG, "json解析完成！");
        } catch (JSONException e) {
            Log.d(TAG, "json解析出错");
            e.printStackTrace();
            return;
        }
        ZhugeSDK.getInstance().identify(this.getActivity().getApplicationContext(), uId, jsonObject);
    }

    void initPushService(){
        ZGPush.getInstance().initialize(this.getActivity().getApplicationContext());
    }
}

class StartAnaly implements FREFunction{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        //appkey, channelID,version, isDebug
        ZhugeAnalyticsContext context = (ZhugeAnalyticsContext) freContext;
        try {
            String appkey = freObjects[0].getAsString();
            String channelID = freObjects[1].getAsString();
            String version = freObjects[2].getAsString();
            Boolean isDebug = freObjects[3].getAsBool();
            context.startAnaly(appkey, channelID, version, isDebug);
        } catch (FRETypeMismatchException e) {
            e.printStackTrace();
        } catch (FREInvalidObjectException e) {
            e.printStackTrace();
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}

class OnEvent implements FREFunction{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        //eventID, s||label
        ZhugeAnalyticsContext context = (ZhugeAnalyticsContext) freContext;
        try {
            String eventID = freObjects[0].getAsString();
            String label = freObjects[1].getAsString();
            context.onEvent(eventID, label);
        } catch (FRETypeMismatchException e) {
            e.printStackTrace();
        } catch (FREInvalidObjectException e) {
            e.printStackTrace();
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}

class Identify implements FREFunction{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        //uId, s
        ZhugeAnalyticsContext context = (ZhugeAnalyticsContext) freContext;
        try {
            String uId = freObjects[0].getAsString();
            String label = freObjects[1].getAsString();
            context.identify(uId, label);
        } catch (FRETypeMismatchException e) {
            e.printStackTrace();
        } catch (FREInvalidObjectException e) {
            e.printStackTrace();
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}

class InitPushService implements FREFunction{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        ZhugeAnalyticsContext context = (ZhugeAnalyticsContext) freContext;
        context.initPushService();
        return null;
    }
}
