package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-10 23:24:46 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.StringTokenizer;
import java.util.Vector;
// --- <<IS-END-IMPORTS>> ---

public final class tokenizer

{
	// ---( internal utility methods )---

	final static tokenizer _instance = new tokenizer();

	static tokenizer _newInstance() { return new tokenizer(); }

	static tokenizer _cast(Object o) { return (tokenizer)o; }

	// ---( server methods )---




	public static final void tokenize (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(tokenize)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required delimiter
		// [i] field:0:required inputString
		// [i] field:0:required keepBlank {"true","false"}
		// [o] field:1:required tokens
		
		// pipeline 
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	delimiterStr = IDataUtil.getString( pipelineCursor, "delimiter" );
		String	distributionStr = IDataUtil.getString( pipelineCursor, "inputString" );
		boolean keepBlank = (new Boolean(IDataUtil.getString( pipelineCursor, "keepBlank" ))).booleanValue();
		String resultList[] = null; 
		Vector v = new Vector();
		
		try
		{
			if ((distributionStr == null)
				|| (delimiterStr == null)
				|| (distributionStr.trim().equals(""))
				|| (delimiterStr.trim().equals(""))) {
				resultList = null;
			}
			
			if (keepBlank) {
			    StringTokenizer t = new StringTokenizer(distributionStr, delimiterStr,true);
				String currStr = "";
				String tmpStr = null;
		
		    	while (t.hasMoreTokens()) {
					tmpStr = t.nextToken();
					if (tmpStr.equals(delimiterStr)) {
						v.addElement(currStr);
						currStr = "";
					} else if (t.hasMoreTokens()) {
						currStr = tmpStr;
					} else {
						v.addElement(tmpStr);
					}
		    	}
		
				if (tmpStr.equals(delimiterStr)) {
					v.addElement("");
				}
		
			} else {
				StringTokenizer t = new StringTokenizer(distributionStr, delimiterStr);
			    while (t.hasMoreTokens()) {
					v.add(t.nextToken().trim());
				}
			}
			resultList = (String[]) v.toArray(new String[0]);
		
		} 
		catch (Exception exc) 
		{
			throw new ServiceException(exc.getMessage());
		} 
		// pipeline
		IDataUtil.put( pipelineCursor, "tokens", resultList );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

