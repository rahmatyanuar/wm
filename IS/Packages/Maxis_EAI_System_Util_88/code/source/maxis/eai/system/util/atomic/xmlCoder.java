package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2013-02-28 17:18:23 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.util.coder.*;
// --- <<IS-END-IMPORTS>> ---

public final class xmlCoder

{
	// ---( internal utility methods )---

	final static xmlCoder _instance = new xmlCoder();

	static xmlCoder _newInstance() { return new xmlCoder(); }

	static xmlCoder _cast(Object o) { return (xmlCoder)o; }

	// ---( server methods )---




	public static final void encodeIDataToXmlStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(encodeIDataToXmlStr)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:0:required inputOfIData
		// [o] field:0:required iDataXmlStr
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData	inputOfIData = IDataUtil.getIData( pipelineCursor, "inputOfIData" );
		
		if ( inputOfIData != null){
			IDataXMLCoder iDataXmlCoder = new IDataXMLCoder() ;
			try{
				byte[] bites = iDataXmlCoder.encodeToBytes(inputOfIData);
				IDataUtil.put( pipelineCursor, "iDataXmlStr", new String(bites) );	
			}catch(Exception e){
				throw new ServiceException(e);
			}finally{
				pipelineCursor.destroy();
			}
		}
		
		
		// --- <<IS-END>> ---

                
	}
}

