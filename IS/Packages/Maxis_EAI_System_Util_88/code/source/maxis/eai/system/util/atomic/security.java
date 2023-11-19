package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
// --- <<IS-END-IMPORTS>> ---

public final class security

{
	// ---( internal utility methods )---

	final static security _instance = new security();

	static security _newInstance() { return new security(); }

	static security _cast(Object o) { return (security)o; }

	// ---( server methods )---




	public static final void generateHMACWithKey (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(generateHMACWithKey)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inputMessage
		// [i] field:0:required secretHashKey
		// [i] field:0:required algorithm {"HmacSHA256","HmacSHA1","HmacMD5"}
		// [o] field:0:required outHex
		// [o] object:0:required outBytes
		try {
			//get IData Input
			IDataCursor pipelineCursorIn = pipeline.getCursor();
			String input = IDataUtil.getString(pipelineCursorIn, "inputMessage");
			String algorithm = IDataUtil.getString(pipelineCursorIn, "algorithm");
			String keyId  = IDataUtil.getString(pipelineCursorIn, "secretHashKey");
		
			
			
			SecretKeySpec key = new SecretKeySpec((keyId).getBytes("UTF-8"), algorithm);
			
		      Mac mac = Mac.getInstance(algorithm);
		      mac.init(key);
		
		      byte[] bytes = mac.doFinal(input.getBytes("UTF-8"));
		
		      StringBuffer hash = new StringBuffer();
		      for (int i = 0; i < bytes.length; i++) {
		        String hex = Integer.toHexString(0xFF & bytes[i]);
		        if (hex.length() == 1) {
		          hash.append('0');
		        }
		        hash.append(hex);
		      }
		
			//write IData output
			IDataCursor pipelineCursorOut = pipeline.getCursor();
			IDataUtil.put(pipelineCursorOut, "outHex",hash.toString());
			IDataUtil.put(pipelineCursorOut, "outBytes",hash);
			pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
			
				
			}  catch (InvalidKeyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(e);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(e);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(e);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(e);
			}		
		// --- <<IS-END>> ---

                
	}
}

