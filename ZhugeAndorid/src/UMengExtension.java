import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM10:49
 * To change this template use File | Settings | File Templates.
 */
public class UMengExtension implements FREExtension{

    public static final String TAG = "UMengExtension";

    private static UMengContext context;
    @Override
    public FREContext createContext(String contextType){
      context =  new UMengContext();
         return     context;
    }

    @Override
    public void dispose(){
    }

    @Override
    public void initialize() {

        Log.d(TAG, "UMengExtension initialized");
    }
}
