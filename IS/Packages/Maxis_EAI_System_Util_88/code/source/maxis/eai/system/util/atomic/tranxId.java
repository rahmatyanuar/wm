package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2017-05-28 18:22:33 SGT
// -----( ON-HOST: PC05QJN1.isddc.men.maxis.com.my

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.security.SecureRandom;
import java.io.*;
import org.apache.commons.lang.RandomStringUtils;
// --- <<IS-END-IMPORTS>> ---

public final class tranxId

{
	// ---( internal utility methods )---

	final static tranxId _instance = new tranxId();

	static tranxId _newInstance() { return new tranxId(); }

	static tranxId _cast(Object o) { return (tranxId)o; }

	// ---( server methods )---




	public static final void getRndAlpahNumericStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRndAlpahNumericStr)>> ---
		// @sigtype java 3.5
		// [i] field:0:required length
		// [o] field:0:required randomStr
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	lengthStr = IDataUtil.getString( pipelineCursor, "length" );
		int length = 3;
		try{
			length = Integer.parseInt(lengthStr);
		}catch(Exception e){}
		IDataUtil.put( pipelineCursor, "randomStr", RandomStringUtils.random(length, true, true));
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	static SecureRandom random = new SecureRandom();
	// --- <<IS-END-SHARED>> ---
}

