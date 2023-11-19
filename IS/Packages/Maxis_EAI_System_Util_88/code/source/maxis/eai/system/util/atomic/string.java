package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class string

{
	// ---( internal utility methods )---

	final static string _instance = new string();

	static string _newInstance() { return new string(); }

	static string _cast(Object o) { return (string)o; }

	// ---( server methods )---




	public static final void checkStringExistance (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkStringExistance)>> ---
		// @sigtype java 3.5
		// [i] field:0:required target
		// [i] field:0:required stringToCheck
		// [i] field:1:required stringListToCheck
		// [i] object:0:required caseSensitive
		// [o] field:0:required exists
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	target = IDataUtil.getString( pipelineCursor, "target" );
			String	stringToCheck = IDataUtil.getString( pipelineCursor, "stringToCheck" );
			String[]	stringListToCheck = IDataUtil.getStringArray( pipelineCursor, "stringListToCheck" );
			boolean	caseSensitive = IDataUtil.getBoolean( pipelineCursor, "caseSensitive" );
		pipelineCursor.destroy();
		boolean exists = false;
		
		try {
			if (target != null && target.trim() != "") {
				if (stringToCheck != null && stringToCheck.trim() != "") {
					if (caseSensitive) {
					exists = stringToCheck.contains(target);
					} else {
						exists = stringToCheck.toUpperCase().contains(target.toUpperCase());
					}
				} else if (stringListToCheck != null) {
					for (String eachString : stringListToCheck) {
						if (eachString != null && eachString.trim() != "") {
							if (caseSensitive) {
								exists = eachString.contentEquals(target);
							} else {
							exists = eachString.equalsIgnoreCase(target);
							}
						}
						if (exists) {
							break;
						}
					}
				}
			}
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "exists", Boolean.toString(exists));
		pipelineCursor_1.destroy();
		}	
		// --- <<IS-END>> ---

                
	}



	public static final void endWithStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(endWithStr)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inputValue
		// [i] field:0:required match
		// [o] field:0:required result
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String input = IDataUtil.getString(pipelineCursor, "inputValue");
		String match = IDataUtil.getString(pipelineCursor, "match");
		pipelineCursor.destroy();
		
		boolean b = input.endsWith(match);
		String result = String.valueOf(b);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put(pipelineCursor_1, "result",result);
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getLastIndexOf (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getLastIndexOf)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required str
		// [i] field:0:optional fromIndex
		// [o] field:0:required result
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	inString = IDataUtil.getString( pipelineCursor, "inString" );
			String	str = IDataUtil.getString( pipelineCursor, "str" );
			String	fromIndexStr = IDataUtil.getString( pipelineCursor, "fromIndex" );
			int result = -1;
		pipelineCursor.destroy();
		if (inString != null) {
			if (fromIndexStr != null) {
			result = inString.lastIndexOf(str, Integer.parseInt(fromIndexStr));
			} else {
				result = inString.lastIndexOf(str);
			}
		}
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "result", Integer.toString(result) );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void setNullIfBlank (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setNullIfBlank)>> ---
		// @sigtype java 3.5
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	inString = IDataUtil.getString( pipelineCursor, "inString" );
		try {
		if ("".equals(inString)) {
			IDataUtil.put( pipelineCursor, "outString", null);			
		} else {
			IDataUtil.put( pipelineCursor, "outString", inString);
		}
		
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally {
		pipelineCursor.destroy();
		}		
		// --- <<IS-END>> ---

                
	}



	public static final void startWithStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(startWithStr)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inputValue
		// [i] field:0:required match
		// [o] field:0:required result
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String input = IDataUtil.getString(pipelineCursor, "inputValue");
		String match = IDataUtil.getString(pipelineCursor, "match");
		pipelineCursor.destroy();
		
		boolean b = input.startsWith(match);
		String result = String.valueOf(b);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put(pipelineCursor_1, "result",result);
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

