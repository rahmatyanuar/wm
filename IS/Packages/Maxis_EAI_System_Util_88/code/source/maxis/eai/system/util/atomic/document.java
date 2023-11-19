package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
// --- <<IS-END-IMPORTS>> ---

public final class document

{
	// ---( internal utility methods )---

	final static document _instance = new document();

	static document _newInstance() { return new document(); }

	static document _cast(Object o) { return (document)o; }

	// ---( server methods )---




	public static final void manageNullFields (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(manageNullFields)>> ---
		// @sigtype java 3.5
		// [i] record:0:required input
		// [i] field:0:optional setBlankIfNull {"true","false"}
		// [i] field:0:optional ignoreBlank
		// [o] record:0:required output
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		// input
		IData input = IDataUtil.getIData(pipelineCursor, "input");
		IData output = IDataFactory.create();
		// setBlankIfNull: Field to indicate whether you need the utility set
		// the value for the field as blank string ("") instead of eliminating
		// the field.
		// Possible values:
		// true - Indicates that if any field in the input document is NULL it
		// will be set to blank in output.
		// false - Default - The field will be just removed from the output
		String setBlankIfNullString = IDataUtil.getString(pipelineCursor, "setBlankIfNull");
		boolean setBlankIfNull = setBlankIfNullString == null ? false : Boolean.parseBoolean(setBlankIfNullString);
		// ignoreBlank: Field to indicate whether the code need to remove/ignore
		// if any field is set as Blank.
		// Possible Values:
		// true - Indicates that the service will ignore blank value for any
		// field (will not do any checking at all). i.e If the field value is
		// blank it will still be copied to output
		// false - Default - Indicates that the service will not ignore blank
		// value for any field (will do a checking). i.e. If the field value is
		// blank it will not be copied to output.
		String ignoreBlankString = IDataUtil.getString(pipelineCursor, "ignoreBlank");
		boolean ignoreBlank = ignoreBlankString == null ? false : Boolean.parseBoolean(ignoreBlankString);
		pipelineCursor.destroy();
		output = manageNullFieldsinDoc(input, setBlankIfNull, ignoreBlank);
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		// output
		IDataUtil.put(pipelineCursor_1, "output", output);
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeEmptyTag (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeEmptyTag)>> ---
		// @sigtype java 3.5
		// [i] record:0:required inputDoc
		// [o] record:0:required outputDoc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData inputDoc = IDataUtil.getIData( pipelineCursor, "inputDoc" );
		if(inputDoc != null){
			IDataCursor inputCur = inputDoc.getCursor();
			IData outputDoc = IDataFactory.create();
			IDataCursor outputCur = outputDoc.getCursor();
			removeEmptyString(inputCur, outputCur);
			inputCur.destroy();
			IDataUtil.put( pipelineCursor, "outputDoc", outputDoc );
		
		}
		pipelineCursor.destroy();			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static IData manageNullFieldsinDoc(IData input, boolean setBlankIfNull, boolean ignoreBlank) {
		IData output = IDataFactory.create();
		IData intermediateOutput = null;
		IDataCursor inputCursor = null, outputCursor = null;
		outputCursor = output.getCursor();
		Object child = null;
		String childString;
		List<IData> childIDataList = null, intermediateOutputList = null;
		if (input != null) {
			inputCursor = input.getCursor();
			while (inputCursor.next()) {
				child = inputCursor.getValue();
				if (child != null) {
					if (child instanceof String) {
						childString = IDataUtil.getString(inputCursor, inputCursor.getKey());
						if (childString == null && setBlankIfNull) {
							IDataUtil.put(outputCursor, inputCursor.getKey(), "");
						} else if ((childString != "") || (childString == "" && ignoreBlank)) {
							IDataUtil.put(outputCursor, inputCursor.getKey(), childString);
						}
					} else if (child instanceof IData) {
						intermediateOutput = IDataFactory.create();
						intermediateOutput = manageNullFieldsinDoc((IData) child, setBlankIfNull, ignoreBlank);
						if (intermediateOutput.getCursor().first()) {
							IDataUtil.put(outputCursor, inputCursor.getKey(), intermediateOutput);
						}
						intermediateOutput = null;
					} else if (child instanceof IData[]) {
						childIDataList = Arrays.asList(((IData[]) child));
						intermediateOutputList = new ArrayList<IData>();
						for (IData childIData : childIDataList) {
							intermediateOutput = IDataFactory.create();
							intermediateOutput = manageNullFieldsinDoc(childIData, setBlankIfNull, ignoreBlank);
							if (intermediateOutput.getCursor().first()) {
								intermediateOutputList.add(intermediateOutput);
							}
							intermediateOutput = null;
						}
						IDataUtil.put(outputCursor, inputCursor.getKey(),
								intermediateOutputList.toArray(new IData[intermediateOutputList.size()]));
					} else {
						IDataUtil.put(outputCursor, inputCursor.getKey(), child);
					}
				}
			}
		}
		return output;
	}
	
	private static void removeEmptyString(IDataCursor inputCur, IDataCursor outputCur){
		while(inputCur.hasMoreData()){	
			inputCur.next();
			String key = inputCur.getKey();
			Object obj0 = inputCur.getValue();
			if(obj0 instanceof IData){
				IData tempIData = IDataFactory.create();
				IDataCursor tempIDataCur = tempIData.getCursor();
				
				IDataCursor tempCur = ((IData)obj0).getCursor();
				removeEmptyString(tempCur, tempIDataCur);
				tempCur.destroy(); 
				tempIDataCur.destroy();
				IDataUtil.put(outputCur, key, tempIData); 
			}else if(obj0 instanceof String){
				String val = IDataUtil.getString(inputCur, key).trim();
				if(!val.equals("")){
					IDataUtil.put(outputCur, key, val);				
				}
			}else if(obj0 instanceof IData[]){
				IData[] idataArr = (IData[])obj0;
				IData[] output = new IData[idataArr.length];
				for(int i=0; i<idataArr.length; i++){
					output[i] = IDataFactory.create();
					IDataCursor tempIDataCur = output[i].getCursor();
				
					IDataCursor tempCur = idataArr[i].getCursor();
					removeEmptyString(tempCur, tempIDataCur);
					tempCur.destroy(); 
					tempIDataCur.destroy();
				}
				IDataUtil.put(outputCur, key, output); 
			}else{
				IDataUtil.put(outputCur, key, obj0);
			}
		}
	}
	// --- <<IS-END-SHARED>> ---
}

