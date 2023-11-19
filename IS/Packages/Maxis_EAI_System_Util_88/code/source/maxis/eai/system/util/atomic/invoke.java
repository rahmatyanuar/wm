package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-11 09:17:21 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.lang.ns.*;
// --- <<IS-END-IMPORTS>> ---

public final class invoke

{
	// ---( internal utility methods )---

	final static invoke _instance = new invoke();

	static invoke _newInstance() { return new invoke(); }

	static invoke _cast(Object o) { return (invoke)o; }

	// ---( server methods )---




	public static final void doInvoke (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(doInvoke)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required serviceName
		// [i] record:0:required inputData
		// [o] record:0:required outputData
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		IData	inputData = IDataUtil.getIData( pipelineCursor, "inputData" );
		NSName targetServiceNSName = NSName.create (serviceName);
		
		try{
			Service.doInvoke (targetServiceNSName, inputData);
			IDataUtil.put( pipelineCursor, "outputData", inputData );
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally{
			pipelineCursor.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void doThreadInvoke (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(doThreadInvoke)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required serviceName
		// [i] record:0:required inputData
		// [o] record:0:required outputData
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	serviceName = IDataUtil.getString( pipelineCursor, "serviceName" );
		IData	inputData = IDataUtil.getIData( pipelineCursor, "inputData" );
		NSName targetServiceNSName = NSName.create (serviceName);
		
		try{
			Service.doThreadInvoke (targetServiceNSName, inputData);
			IDataUtil.put( pipelineCursor, "outputData", inputData );
		} catch (Exception e) {
			throw new ServiceException(e);
		} finally{
			pipelineCursor.destroy();
		}
		// --- <<IS-END>> ---

                
	}
}

