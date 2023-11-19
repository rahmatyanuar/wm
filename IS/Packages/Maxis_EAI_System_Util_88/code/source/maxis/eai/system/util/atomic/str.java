package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.security.SecureRandom;
import java.io.*;
// --- <<IS-END-IMPORTS>> ---

public final class str

{
	// ---( internal utility methods )---

	final static str _instance = new str();

	static str _newInstance() { return new str(); }

	static str _cast(Object o) { return (str)o; }

	// ---( server methods )---




	public static final void getAmdocsFaultCode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAmdocsFaultCode)>> ---
		// @sigtype java 3.5
		// [i] field:0:required faultString
		// [o] field:0:required faultCode
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	faultString = IDataUtil.getString( pipelineCursor, "faultString" );
		int startIdx = faultString.indexOf("(");
		int endIdx = faultString.indexOf(")");
		String faultCode = "2";
		try{
			faultCode = faultString.substring(startIdx+1, endIdx);
		} catch (Exception e){
			faultCode = "2";
		}
		IDataUtil.put( pipelineCursor, "faultCode", faultCode );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getIsStringMatches (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getIsStringMatches)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inStr
		// [i] field:0:required regexStr
		// [o] field:0:required isMatch
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	inStr = IDataUtil.getString( pipelineCursor, "inStr" );
		String	regexStr = IDataUtil.getString( pipelineCursor, "regexStr" );
		String isMatch = "N";
				
		if(inStr.matches(regexStr)){
			isMatch = "Y";
		}
				
		IDataUtil.put( pipelineCursor, "isMatch", isMatch );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	static SecureRandom random = new SecureRandom();
	// --- <<IS-END-SHARED>> ---
}

