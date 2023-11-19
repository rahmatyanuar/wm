package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
// --- <<IS-END-IMPORTS>> ---

public final class aesEncryption

{
	// ---( internal utility methods )---

	final static aesEncryption _instance = new aesEncryption();

	static aesEncryption _newInstance() { return new aesEncryption(); }

	static aesEncryption _cast(Object o) { return (aesEncryption)o; }

	// ---( server methods )---




	public static final void decryptWithSecret (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(decryptWithSecret)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inStr
		// [i] field:0:required secret
		// [i] field:0:required algorithm
		// [o] field:0:required outStr
		try {
			// get IData Input
			IDataCursor pipelineCursorIn = pipeline.getCursor();
			String inStr = IDataUtil.getString(pipelineCursorIn, "inStr");
			String secret = IDataUtil.getString(pipelineCursorIn, "secret");
			String algorithm = IDataUtil.getString(pipelineCursorIn, "algorithm");
			
			
		    setKey(secret, algorithm);
		    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
		    cipher.init(Cipher.DECRYPT_MODE, secretKey);
		    
		    String outStr = new String(cipher.doFinal(Base64.getDecoder().decode(inStr)));
		    
		    //write IData Output
		    IDataCursor pipelineCursorOut = pipeline.getCursor();
		    IDataUtil.put(pipelineCursorOut, "outStr", outStr);
		    pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
		    
		}
		catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		}		
		// --- <<IS-END>> ---

                
	}



	public static final void encryptWithSecret (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encryptWithSecret)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inStr
		// [i] field:0:required secret
		// [i] field:0:required algorithm
		// [o] field:0:required outStr
		try {
			// get IData Input
			IDataCursor pipelineCursorIn = pipeline.getCursor();
			String inStr = IDataUtil.getString(pipelineCursorIn, "inStr");
			String secret = IDataUtil.getString(pipelineCursorIn, "secret");
			String algorithm = IDataUtil.getString(pipelineCursorIn, "algorithm");
			
		    setKey(secret, algorithm);
		    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
		    cipher.init(Cipher.ENCRYPT_MODE, secretKey);
		    
		    String outStr = Base64.getEncoder().encodeToString(cipher.doFinal(inStr.getBytes("UTF-8")));
		    
		    //write IData Output
		    IDataCursor pipelineCursorOut = pipeline.getCursor();
		    IDataUtil.put(pipelineCursorOut, "outStr", outStr);
		    pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
		}
		catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e);
		}
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static SecretKeySpec secretKey;
	private static byte[] key;
	
	public static void setKey(String myKey, String algorithm) throws ServiceException {
	    MessageDigest sha = null;
	    try {
	        key = myKey.getBytes("UTF-8");
	        sha = MessageDigest.getInstance(algorithm);
	        key = sha.digest(key);
	        key = Arrays.copyOf(key, 16);
	        secretKey = new SecretKeySpec(key, "AES");
	    }
	    catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        throw new ServiceException(e);
	    }
	    catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        throw new ServiceException(e);
	    }
	    catch (Exception e) {
	    	e.printStackTrace();
	    	throw new ServiceException(e);
	    }
	}
	// --- <<IS-END-SHARED>> ---
}

