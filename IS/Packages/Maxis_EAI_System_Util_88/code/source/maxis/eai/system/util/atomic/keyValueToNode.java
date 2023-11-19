package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.Vector;
// --- <<IS-END-IMPORTS>> ---

public final class keyValueToNode

{
	// ---( internal utility methods )---

	final static keyValueToNode _instance = new keyValueToNode();

	static keyValueToNode _newInstance() { return new keyValueToNode(); }

	static keyValueToNode _cast(Object o) { return (keyValueToNode)o; }

	// ---( server methods )---




	public static final void keyValueToNode (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(keyValueToNode)>> ---
		// @sigtype java 3.5
		// [i] record:1:required keyValueToNodeInputList
		// [i] - record:1:required attributeList
		// [i] -- field:0:required key
		// [i] -- field:0:required value
		// [o] record:1:required keyValueToNodeOutputList
		IDataCursor pipelineCursor = pipeline.getCursor();
		
		// get keyValueNodeInputList
		IData[]	keyValueToNodeInputList = IDataUtil.getIDataArray( pipelineCursor, "keyValueToNodeInputList" );
		if ( keyValueToNodeInputList != null) {
			Vector<IData>  vectorOutputIData = new Vector<IData>();
			
			// loop keyValueToNodeInputList
			for ( int i = 0; i < keyValueToNodeInputList.length; i++ ){	
				IData tempOutputListIData =  IDataFactory.create();
				IDataCursor tempOutputListIDataCur = tempOutputListIData.getCursor();
				
				IDataCursor keyValueToNodeInputListCursor = keyValueToNodeInputList[i].getCursor();	
				
				// get attributeList
				IData[]	attributeList = IDataUtil.getIDataArray( keyValueToNodeInputListCursor, "attributeList" );
				if ( attributeList != null){
					// loop attributeList
					for ( int j = 0; j < attributeList.length; j++ ){
						IDataCursor attributeListCursor = attributeList[j].getCursor();	
						String	key = IDataUtil.getString( attributeListCursor, "key" );
						String	value = IDataUtil.getString( attributeListCursor, "value" );
						
						if (key != null && value != null) {
							IDataUtil.put( tempOutputListIDataCur, key, value );
						}
						
						attributeListCursor.destroy();	
					}
				}
				
				if (IDataUtil.size(tempOutputListIDataCur) != 0) { 
					vectorOutputIData.add(tempOutputListIData);
					IDataUtil.put( pipelineCursor, "keyValueToNodeOutputList", vectorOutputIData.toArray(new IData[i]));					
				}
						
				tempOutputListIDataCur.destroy();
				keyValueToNodeInputListCursor.destroy();
				
			}
		}
		pipelineCursor.destroy();
		
		
			
		// --- <<IS-END>> ---

                
	}
}

