package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-10 23:24:15 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.*;
import com.wm.util.*;
import java.io.*;
import java.util.*;
import java.text.*;
// --- <<IS-END-IMPORTS>> ---

public final class numeric

{
	// ---( internal utility methods )---

	final static numeric _instance = new numeric();

	static numeric _newInstance() { return new numeric(); }

	static numeric _cast(Object o) { return (numeric)o; }

	// ---( server methods )---




	public static final void filterNumeric (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(filterNumeric)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] field:0:required outString
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	inString = IDataUtil.getString( pipelineCursor, "inString" );
		pipelineCursor.destroy();
		
		char[] charArray = inString.toCharArray();
		char[] resultArray = new char[inString.length()];
		int j = 0;
		
		for (int i=0; i < charArray.length; i++)
		{
			if (Character.isDigit(charArray[i]))
				resultArray[j++] = charArray[i];
		}
		
		String outString = new String(resultArray);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "outString", outString.trim() );
		pipelineCursor_1.destroy();
		  
		// --- <<IS-END>> ---

                
	}
}

