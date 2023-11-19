package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2013-10-30 12:34:56 MYT
// -----( ON-HOST: SGBINTGDEV.men.maxis.com.my

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.eaio.uuid.UUID;
// --- <<IS-END-IMPORTS>> ---

public final class uuid

{
	// ---( internal utility methods )---

	final static uuid _instance = new uuid();

	static uuid _newInstance() { return new uuid(); }

	static uuid _cast(Object o) { return (uuid)o; }

	// ---( server methods )---




	public static final void getUUID (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getUUID)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required prefix
		// [i] field:0:required isWithHyphen {"true","false"}
		// [o] field:0:required uuid
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	prefix = IDataUtil.getString( pipelineCursor, "prefix" );
		String	isWithHyphenStr = IDataUtil.getString( pipelineCursor, "isWithHyphen" );
		boolean isWithHypen = false;
		
		if(isWithHyphenStr != null && isWithHyphenStr.trim().equalsIgnoreCase("true")){
			isWithHypen = true;
		}
		
		UUID uuid = new UUID();
		String uuidStr = uuid.toString();
		if(isWithHypen == false){
			uuidStr = uuid.toString().replaceAll("-", "");
		}
		
		if(prefix == null || prefix.trim().equals("")){
			IDataUtil.put( pipelineCursor, "uuid", uuidStr);
		}else{
			IDataUtil.put( pipelineCursor, "uuid", prefix + uuidStr);
		}
		
		pipelineCursor.destroy();
		
		
		
		
		
			
		// --- <<IS-END>> ---

                
	}
}

