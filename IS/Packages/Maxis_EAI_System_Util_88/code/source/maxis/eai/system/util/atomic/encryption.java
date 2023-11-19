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
import java.util.Base64;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
// --- <<IS-END-IMPORTS>> ---

public final class encryption

{
	// ---( internal utility methods )---

	final static encryption _instance = new encryption();

	static encryption _newInstance() { return new encryption(); }

	static encryption _cast(Object o) { return (encryption)o; }

	// ---( server methods )---




	public static final void encryptHash (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encryptHash)>> ---
		// @sigtype java 3.5
		// [i] field:0:required input
		// [i] field:0:required algorithm {"MD2","MD5","SHA-1","SHA-256","SHA-384","SHA-512"}
		// [o] field:0:required outHex
		// [o] object:0:required outBytes
		try {
			//get IData Input
			IDataCursor pipelineCursorIn = pipeline.getCursor();
			String input = IDataUtil.getString(pipelineCursorIn, "input");
			String algorithm = IDataUtil.getString(pipelineCursorIn, "algorithm");
			//initialize MessageDigest class
			MessageDigest digest;
			//generate key
			digest = MessageDigest.getInstance(algorithm);
			//convert key to bytes
			byte[] hash = digest.digest();
			hash = digest.digest(input.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();
			
			//convert bytes to hex
			for (int i = 0; i < hash.length; i++)
			{
			String hex = Integer.toHexString(0xff & hash[i]);
			if(hex.length() == 1) hexString.append('0');
			hexString.append(hex);
			}
			//write IData output
			IDataCursor pipelineCursorOut = pipeline.getCursor();
			IDataUtil.put(pipelineCursorOut, "outHex",hexString.toString());
			IDataUtil.put(pipelineCursorOut, "outBytes",hash);
			pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
			
				
			} catch (NoSuchAlgorithmException e) {
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



	public static final void encryptHmac (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encryptHmac)>> ---
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
			
			Mac mac = Mac.getInstance(algorithm);
			SecretKeySpec secret_key = new SecretKeySpec(secret.getBytes("UTF-8"), algorithm);
			mac.init(secret_key);
			
			String outStr = Base64.getEncoder().encodeToString(mac.doFinal(inStr.getBytes("UTF-8")));
			
			//write IData Output
			IDataCursor pipelineCursorOut = pipeline.getCursor();
			IDataUtil.put(pipelineCursorOut, "outStr", outStr);
			pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
		}
		catch (NoSuchAlgorithmException e) {
		    e.printStackTrace();
		}
		catch (UnsupportedEncodingException e) {
		    e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
			
		// --- <<IS-END>> ---

                
	}
}

