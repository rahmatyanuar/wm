package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.*;
import java.lang.System;
import java.text.*;
import java.util.*;
import java.io.*;
import java.security.*;
import java.math.*;
import com.wm.util.Debug;
// --- <<IS-END-IMPORTS>> ---

public final class misc

{
	// ---( internal utility methods )---

	final static misc _instance = new misc();

	static misc _newInstance() { return new misc(); }

	static misc _cast(Object o) { return (misc)o; }

	// ---( server methods )---




	public static final void bytesToHexStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(bytesToHexStr)>> ---
		// @sigtype java 3.5
		// [i] object:0:required bytes
		// [o] field:0:required str
		IDataCursor pipelineCursor = pipeline.getCursor();
		byte[] bytes = (byte[]) IDataUtil.get( pipelineCursor, "bytes" );
		
		StringBuilder sb = new StringBuilder(); 
		for(byte b : bytes){ 
			sb.append(String.format("%02x", b&0xff)); 
		} 
				
		IDataUtil.put( pipelineCursor, "str", sb.toString());		
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void concatTwoDocs (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(concatTwoDocs)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:0:required Doc1
		// [i] record:0:required Doc2
		// [o] record:0:required finalDoc
		IDataCursor idc = pipeline.getCursor();
		
		try {
		
			IData inputDoc1 = IDataUtil.getIData(idc, "Doc1");
			IData inputDoc2 = IDataUtil.getIData(idc, "Doc2");
		
			if ((inputDoc1 == null) && (inputDoc2 == null)) return;
		
			if ((inputDoc1 != null) && (inputDoc2 != null)) {
				IDataUtil.append(inputDoc1, inputDoc2);
				IDataUtil.put(idc,"finalDoc",inputDoc2);
		
			} else if (inputDoc1 != null) {
				IDataUtil.put(idc, "finalDoc", inputDoc1);
		
			} else	if (inputDoc2 != null) {
				IDataUtil.put(idc, "finalDoc", inputDoc2);
			}
		
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void directoryListings (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(directoryListings)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required directory
		// [o] field:1:required fileNames
		// [o] field:1:required directoryNames
		// [o] field:1:required fullFileNames
		// [o] field:1:required fullDirectoryNames
		// [o] field:0:required absolutePath
		// [o] field:0:required separator
		// [o] field:0:required status
		// pipeline - in
		IDataCursor pc = pipeline.getCursor(); 
		String	directory = IDataUtil.getString( pc, "directory" );
		String	filter = IDataUtil.getString( pc, "filter" );
		String 	status = "OK";
		String 	ap = null, 	// absolute path
			s = null;		// file separator
		Vector fn = new Vector();
		Vector dn = new Vector();
		Vector ffn = new Vector();
		Vector fdn = new Vector();
		String[] sfn = null, 	// abstract file names
			sdn = null, 	// abstract directory names
			sffn = null, 	// absolute file names 
			sfdn = null;	// absolute directory names
		File f = null, t = null;
		
		try{
			int x = 0;
		
			f = new File(directory);
			
			if(f.exists()){
				ap = f.getAbsolutePath();
				s = f.separator;
		
				String fl[] = f.list();
				
				// get the array size
				int as = Arrays.asList(fl).size();
		
				while(fl[x]!= null){
					t = new File(ap + s + fl[x]);
					if(t.isFile()) {
						fn.add(fl[x]);
						ffn.add(ap + s + fl[x]);
					}
					if(t.isDirectory()){
						dn.add(fl[x]);
						fdn.add(ap + s + fl[x]);
					}
					x++;
					// exit when last array index reached
					if(as == x) break;
				}
		
				// lets put the vectors into string list
				try{ // file name string array 
					sfn = new String[fn.size()];
					for(x = 0; x < fn.size(); x++)
						sfn[x] = (String)fn.elementAt(x);
		
				}catch(Exception e){}
				try{ // directory name string array
					sdn = new String[dn.size()];
					for(x = 0; x < dn.size(); x++)
						sdn[x] = (String)dn.elementAt(x);
		
				}catch(Exception e){}
				try{ // full file name string array
					sffn = new String[ffn.size()];
					for(x = 0; x < ffn.size(); x++)
						sffn[x] = (String)ffn.elementAt(x);
		
				}catch(Exception e){}
				try{ // full directory name string array
					sfdn = new String[fdn.size()];
					for(x = 0; x < fdn.size(); x++)
						sfdn[x] = (String)fdn.elementAt(x);
		
				}catch(Exception e){}
			}
			else{
				status = f + " does not exists!";
			}
		}
		catch(Exception e){
			status = e.toString();
		}
		
		
		// pipeline - out
		IDataUtil.put( pc, "fileNames", sfn );
		IDataUtil.put( pc, "directoryNames", sdn);
		IDataUtil.put( pc, "fullFileNames", sffn );
		IDataUtil.put( pc, "fullDirectoryNames", sfdn);
		IDataUtil.put( pc, "absolutePath", ap);
		IDataUtil.put( pc, "separator", s);
		IDataUtil.put( pc, "status", status );
		pc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void generateNonce (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(generateNonce)>> ---
		// @sigtype java 3.5
		IDataCursor pipelineCursor = pipeline.getCursor();
		SecureRandom random = new SecureRandom();
		String Nonce = "";
		try {
			Nonce = new BigInteger(130, random).toString(32);
		} catch (Exception e) {
			
		} finally {
			IDataUtil.put(pipelineCursor, "Nonce", Nonce);
			pipelineCursor.destroy();
		}	
		// --- <<IS-END>> ---

                
	}



	public static final void getCPUUsage (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCPUUsage)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required OSUserName
		// [o] field:0:required status
		// [o] field:0:required output
		// [o] field:0:required error
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	strOSUserName = IDataUtil.getString( pipelineCursor, "OSUserName" );
		String strCommand = "";
		String strSynchronous="true";
		String strOutput = "";
		String strError = "";
		Process process = null;
		try
		{
			// prepare Move Command
			strCommand = "prstat -tu" + strOSUserName +" 3 1";
			//strCommand = "prstat -t 3 1";
			//Debug.log (1, "prstat command = "+ strCommand);
			
			//to execute OS Command
			process = (Runtime.getRuntime()).exec(strCommand);
			if (strSynchronous.equals("true"))
			{
				// Provide an outlet for IO for the process
				String line; 
				BufferedReader ir = new BufferedReader(new InputStreamReader(process.getInputStream())); 
				BufferedReader er = new BufferedReader(new InputStreamReader(process.getErrorStream())); 
				while ((line = ir.readLine()) != null) 
				{
					strOutput += line + '\n';
				} 
				while ((line = er.readLine()) != null) 
				{
					strError += line + '\n';
				} 
				ir.close(); 
				er.close(); 
				process.waitFor();
			}
		}
		catch (Exception e)
		{
			throw new ServiceException(e.toString());
		}
		finally
		{
			if (strSynchronous.equals("true") && process != null)
			{
				int status = process.exitValue();
				pipelineCursor.insertAfter("status", Integer.toString(status));
			}
			pipelineCursor.insertAfter("output", strOutput);
			pipelineCursor.insertAfter("error", strError);
			process.destroy();
			pipelineCursor.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getMaxMinNoOrdered (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getMaxMinNoOrdered)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required Records
		// [i] - field:0:required Field
		// [o] field:0:required minNo
		// [o] field:0:required maxNo
		// [o] field:0:required count
		// [o] record:1:required rangeList
		// [o] - field:0:required minNo
		// [o] - field:0:required maxNo
		IDataCursor idc = pipeline.getCursor();
		long maxRecSeqn=0, minRecSeqn=0, tempRecSeqn=0;
		int recordsLength=0;
		String strFieldString="";
		long curSeqNo=0, prevSeqNo=0, maxNo=0, minNo=0;
		Vector vRangeList = new Vector(0,0);
		try {
			//IData[] Records = IDataUtil.sortIDataArrayByKey(IDataUtil.getIDataArray(idc, "Records"),"Field",IDataUtil.COMPARE_TYPE_NUMERIC,null,false);  
			IData[] Records = IDataUtil.getIDataArray(idc, "Records");          
			if (Records == null) {
			IDataUtil.put(idc, "maxField", null);
			IDataUtil.put(idc, "count",  "0");
			IDataUtil.put(idc, "minNo", "0");
			IDataUtil.put(idc, "maxNo", "0");
			return;
			}
			recordsLength = Records.length;
		
			//To get Minimum No	
		        IDataCursor minIdc = Records[0].getCursor();
			minRecSeqn= Long.parseLong(IDataUtil.getString(minIdc, "Field").trim());
		        
			//To get Maximum No
			IDataCursor maxIdc = Records[recordsLength-1].getCursor();
			maxRecSeqn= Long.parseLong(IDataUtil.getString(maxIdc, "Field").trim());
			
			for (int i=0; i < recordsLength; i++)
			{
				IDataCursor curIdc = Records[i].getCursor();
				curSeqNo= Long.parseLong(IDataUtil.getString(curIdc, "Field").trim());
				curIdc.destroy();
				if ( i == 0 )
				{
					minNo = curSeqNo;
					maxNo = curSeqNo;
				}
				else
				{
					IDataCursor prevIdc = Records[i-1].getCursor();
					prevSeqNo= Long.parseLong(IDataUtil.getString(prevIdc, "Field").trim());
					prevIdc.destroy();
		
					if (curSeqNo ==  prevSeqNo + 1)
					{
						maxNo = curSeqNo;
					}
					else
					{
						IData curDoc = IDataFactory.create();
						IDataCursor curDocIdc = curDoc.getCursor();
						IDataUtil.put(curDocIdc, "minNo", new Long(minNo).toString());
						IDataUtil.put(curDocIdc, "maxNo", new Long(maxNo).toString());
						curDocIdc.destroy();
						vRangeList.addElement(curDoc);
						minNo = curSeqNo;
						maxNo = curSeqNo;
					}
				}
			}
			//to add last number
			IData curDoc = IDataFactory.create();
			IDataCursor curDocIdc = curDoc.getCursor();
			IDataUtil.put(curDocIdc, "minNo", new Long(minNo).toString());
			IDataUtil.put(curDocIdc, "maxNo", new Long(maxNo).toString());
			curDocIdc.destroy();
			vRangeList.addElement(curDoc);
		
			//prepare Pipeline
			if (vRangeList.size() > 0) 
			{
				IData rangeList[] = (IData[])vRangeList.toArray(new IData[0]);
				IDataUtil.put(idc, "rangeList", rangeList);
				Debug.log (1, "The size :" + vRangeList.size());
			}
		
			IDataUtil.put(idc, "minNo", new Long(minRecSeqn).toString());
			IDataUtil.put(idc, "maxNo", new Long(maxRecSeqn).toString() );	
			IDataUtil.put(idc, "count", new Integer(recordsLength).toString());
			idc.destroy();
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getMaxMinNoUnOrdered (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getMaxMinNoUnOrdered)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required Records
		// [i] - field:0:required Field
		// [o] field:0:required maxNo
		// [o] field:0:required minNo
		IDataCursor idc = pipeline.getCursor();
		long maxRecSeqn=0, minRecSeqn=0, tempRecSeqn=0, recordsLength=0;
		try {
			IData[] Records = IDataUtil.getIDataArray(idc, "Records");
			if (Records == null) {
			IDataUtil.put(idc, "maxField", null);
			IDataUtil.put(idc, "size",  "0");
			return;
			}
			recordsLength = Records.length;
			for (int i=0; i <= recordsLength-1; i++) 
			{
				IDataCursor sIdc = Records[i].getCursor();
				tempRecSeqn= Long.parseLong(IDataUtil.getString(sIdc, "Field").trim());
				if (i==0) {minRecSeqn = tempRecSeqn;}
				if (maxRecSeqn < tempRecSeqn)
				{
					maxRecSeqn = tempRecSeqn;
				}
				if (minRecSeqn > tempRecSeqn)
				{
					minRecSeqn = tempRecSeqn;
				}
			}
			
			IDataUtil.put(idc, "maxNo", new Long(maxRecSeqn).toString() );
			IDataUtil.put(idc, "minNo", new Long(minRecSeqn).toString());
		
		idc.destroy();
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getRandomNum (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRandomNum)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required totalDigit
		// [o] field:0:required randomNum
		try {
			//get IData input
			IDataCursor pipelineCursorIn = pipeline.getCursor();
			String totalDigit = IDataUtil.getString(pipelineCursorIn, "totalDigit");
			//convert totalDigit to int
			int totalDigitInt = Integer.parseInt(totalDigit);
			
			//get maxRandomNum
			String maxRandomNum = "";
			for (int j = 0; j < totalDigitInt; j++) {		
				maxRandomNum ="9" + maxRandomNum;
			}
			
			//get pad
			String pad = "";
			for (int i = 0; i < totalDigitInt; i++) {		
				pad ="0" + pad;
			}
			//generate random key
			Random randomGenerator = new Random();
			int randomInt = randomGenerator.nextInt(Integer.parseInt(maxRandomNum));
			int len = String.valueOf(randomInt).length();
			String tacCode = pad.substring(len) + randomInt;
			
			//write IData output
			IDataCursor pipelineCursorOut = pipeline.getCursor();
			IDataUtil.put(pipelineCursorOut, "tacCode", tacCode);
			pipelineCursorIn.destroy();
			pipelineCursorOut.destroy();
			
			
			} catch (Exception e) {
				throw new ServiceException(e);
				// TODO: handle exception
			}
		// --- <<IS-END>> ---

                
	}



	public static final void getServerInformation (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServerInformation)>> ---
		// @sigtype java 3.5
		// [o] field:0:required serverName
		// [o] field:0:required primaryPort
		// [o] field:0:required currentPort
		 
			IDataCursor idcPipeline = pipeline.getCursor();
		
			String strServerName = ServerAPI.getServerName();
			int intCurrentPort = ServerAPI.getCurrentPort();
		
			IData listenerInfo = null;
			Integer intPrimaryPort = null;
		
			try
			{
				IData results = Service.doInvoke("wm.server.net.listeners", "getPrimaryListener", pipeline);
				IDataUtil.merge(results, pipeline);
		
			}
			catch(Exception e)
			{
				throw new ServiceException("Could not invoke wm.server.net.listeners:getPrimaryListener: " + e);
			}
		
			if (idcPipeline.first("primary"))
			{
				listenerInfo = (IData)idcPipeline.getValue();
				idcPipeline.delete();
			}
			IDataCursor idcListenerInfo = listenerInfo.getCursor();
		
			if (idcListenerInfo.first("port"))
			{
				intPrimaryPort = (Integer)idcListenerInfo.getValue();
			}
		
			idcPipeline.insertAfter("serverName", strServerName);
		        //idcPipeline.insertAfter("serverName", "EAI");
			idcPipeline.insertAfter("primaryPort", intPrimaryPort.toString());
			idcPipeline.insertAfter("currentPort", Integer.toString(intCurrentPort));
		        //idcPipeline.insertAfter("serverName", "EAI");
			//idcPipeline.insertAfter("primaryPort", "5555");
			//idcPipeline.insertAfter("currentPort", "5555");
		
		// Clean up IData cursors
			//idcListenerInfo.destroy();
			idcPipeline.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void moveFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(moveFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required moveFrom
		// [i] field:0:required moveTo
		// [o] field:0:required status
		// pipeline - in 
		IDataCursor pc = pipeline.getCursor();
		String	moveFrom = IDataUtil.getString( pc, "moveFrom" );
		String	moveTo = IDataUtil.getString( pc, "moveTo" );
		File f, t = null; 
		boolean result;
		String status = "FAILED";
		
		try{
			f = new File(moveFrom);	// source file
			t = new File(moveTo);	// target file
			
			if(f.exists()){			// check whether source file exists
				if(t.exists()){		// check whether target file exists
					status = "File already exists in target directory!";
				}
				else{
					if(f.renameTo( t ))	// check whether moving file was successful
						status = "OK";
				}
			}
			else{
				status = f + " does not exist!";
			}
		}
		catch(Exception e){
			// do nothing
			status = e.toString();
		}
		
		
		// pipeline - out
		IDataUtil.put( pc, "status", status );
		pc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void removeDuplicatesFromDocList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeDuplicatesFromDocList)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required inputDocList
		// [i] field:0:required key
		// [i] field:0:required caseSensitive {"true","false"}
		// [o] record:1:required outputDocList
		IDataCursor idc = pipeline.getCursor();
		IData[] inList = null;
		IData[] outList = null;
		String key = null;
		boolean caseSensitive = true;
		
		try {
			inList = IDataUtil.getIDataArray(idc, "inputDocList");
		
			if (inList == null) {
				return;
			}
		
			key = IDataUtil.getString(idc, "key");
			caseSensitive = IDataUtil.getBoolean(idc, "caseSensitive", true);
		
			IDataCursor inIdc = null;
			int len = inList.length;
			Hashtable tmpHT = new Hashtable();
			String currKey = null;
		
			for (int i=0; i < len; i++) {
				inIdc = inList[i].getCursor();
				currKey = IDataUtil.getString(inIdc, key);
				if ((currKey != null) && (!currKey.trim().equals(""))) {
					if (!caseSensitive) {
						currKey = currKey.toUpperCase();
					}
					tmpHT.put(currKey, inList[i]);
				}
				inIdc.destroy();
			}
		
			Enumeration distinctEnum = tmpHT.keys();
			Vector tmpV = new Vector(0,0);
		
			while (distinctEnum.hasMoreElements()) {
				tmpV.addElement((IData) tmpHT.get(distinctEnum.nextElement()));
			}
		
			if (tmpV.size() > 0) {
				outList = (IData[]) tmpV.toArray(new IData[0]);
				IDataUtil.sortIDataArrayByKey(outList, key, IDataUtil.COMPARE_TYPE_COLLATION, null, false);
			}
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		} finally {
			IDataUtil.put(idc, "outputDocList", outList);
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void removeDuplicatesFromStrList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(removeDuplicatesFromStrList)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:1:required inputStrList
		// [i] field:0:optional caseSensitive {"true","false"}
		// [o] field:1:required outputStrList
		IDataCursor idc = pipeline.getCursor();
		String[] inList = null;
		String[] outList = null;
		boolean caseSensitive = true;
		
		try {
			inList = IDataUtil.getStringArray(idc, "inputStrList");
		
			if (inList == null) {
				return;
			}
		
			caseSensitive = IDataUtil.getBoolean(idc, "caseSensitive", true);
		
			int len = inList.length;
			Hashtable tmpHT = new Hashtable();
		
			for (int i=0; i < len; i++) {
				if ((inList[i] != null) && (!inList[i].trim().equals(""))) {
					if (!caseSensitive) {
						inList[i] = inList[i].toUpperCase();
					}
					tmpHT.put(inList[i], "");
				}
			}
		
			Enumeration distinctEnum = tmpHT.keys();
			Vector tmpV = new Vector(0,0);
		
			while (distinctEnum.hasMoreElements()) {
				tmpV.addElement((String) distinctEnum.nextElement());
			}
		
			if (tmpV.size() > 0) {
				outList = (String[]) tmpV.toArray(new String[0]);
				Arrays.sort(outList);
			}
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		} finally {
			IDataUtil.put(idc, "outputStrList", outList);
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void searchFieldValueFromDoc (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(searchFieldValueFromDoc)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:0:required doc
		// [i] field:0:required searchFieldName
		// [o] field:0:required fieldValue
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		
			// doc
			IData	doc = IDataUtil.getIData( pipelineCursor, "doc" );
			IDataCursor searchDocIdc = doc.getCursor();
			if ( doc == null)
			{
				throw new ServiceException("Invalid Input Document");
			}
			String	searchFieldName = IDataUtil.getString( pipelineCursor, "searchFieldName");
			String  fieldValue = IDataUtil.getString (searchDocIdc , searchFieldName);
			
		pipelineCursor.destroy();
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "fieldValue", fieldValue );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void sleepThread (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sleepThread)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required milliSeconds
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	milliSeconds = IDataUtil.getString( pipelineCursor, "milliSeconds" );
		pipelineCursor.destroy();
		// pipeline
		try
		{
			Thread.sleep(new Integer(milliSeconds).intValue());
		}
		catch (Exception exc)
		{
			ServerAPI.logError(exc);
			new ServiceException("Exception occured in sleepThread service "+ exc.getMessage());
		}
		// --- <<IS-END>> ---

                
	}



	public static final void sortDocList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sortDocList)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:1:required inputDocList
		// [i] field:0:required key
		// [i] field:0:optional sortDescending {"true","false"}
		// [o] record:1:required outputDocList
		IDataCursor idc = pipeline.getCursor();
		IData[] inList = null;
		IData[] outList = null;
		String key = null;
		boolean sortDescending = true;
		
		try {
			inList = IDataUtil.getIDataArray(idc, "inputDocList");
		
			if (inList == null) {
				return;
			}
		
			key = IDataUtil.getString(idc, "key");
			if (idc.first("sortDescending")) {
				sortDescending = IDataUtil.getBoolean(idc, "sortDescending");
			}
		
			if (inList.length > 0) {
				outList = inList;
				IDataUtil.sortIDataArrayByKey(outList, key, IDataUtil.COMPARE_TYPE_COLLATION, null, sortDescending);
			}
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		} finally {
			IDataUtil.put(idc, "outputDocList", outList);
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void stringToStringList (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToStringList)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required distributionStr
		// [i] field:0:required delimiterStr
		// [i] field:0:required keepBlankStr {"true","false"}
		// [o] field:1:required distributionList
		IDataCursor idc = pipeline.getCursor();
		Vector v = new Vector();
		
		try {
		
			String distributionStr = IDataUtil.getString(idc, "distributionStr");
			String delimiterStr = IDataUtil.getString(idc, "delimiterStr");
			boolean keepBlank = IDataUtil.getBoolean(idc, "keepBlankStr", true);
			//boolean keepBlank = new Boolean(keepBlankStr).booleanValue();
		
			if ((distributionStr == null)
				|| (delimiterStr == null)
				|| (distributionStr.trim().equals(""))
				|| (delimiterStr.trim().equals(""))) {
				idc.destroy();
				return;
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
			String resultList[] = (String[]) v.toArray(new String[0]);
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		} finally {
			IDataUtil.put(idc, "distributionList", (String[]) v.toArray(new String[0]));
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void throwServiceException (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(throwServiceException)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required exceptionMessage
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String exceptionMessage = IDataUtil.getString( pipelineCursor, "exceptionMessage" );
		pipelineCursor.destroy();
		
		throw new ServiceException(exceptionMessage);
		// --- <<IS-END>> ---

                
	}



	public static final void truncateString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(truncateString)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required trunc {"left","right"}
		// [i] field:0:required keyFilter
		// [o] field:0:required value
		IDataCursor idc = pipeline.getCursor();
		String keyFilter = null;
		String inString = null;
		String trunc = null;
		String result = null;
		
		try {
			
			inString = IDataUtil.getString(idc, "inString");
		
			if (inString == null) {
				return;
			}
			
			keyFilter = IDataUtil.getString(idc, "keyFilter");
			trunc = IDataUtil.getString(idc, "trunc");
			int inStringlen = inString.length();
			int keyPosition = inString.indexOf(keyFilter);
		
			//Debug.log(1,"trunc : " + trunc + " inStringlen : " + inStringlen + " keyPosition: " + keyPosition);
		
			if (keyPosition < 0) {
				result = inString;
				return;
			}
		
			if (trunc.equals("left")) {
				result = inString.substring(keyPosition, inStringlen);
			} else if (trunc.equals("right")) {
				result = inString.substring(0,keyPosition);
			}
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		} finally {
			IDataUtil.put(idc, "value", result);
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}
}

