package WxPreUpgradeAnalyzer.excel.pub;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.channels.FileChannel;
import java.nio.file.Paths;
// --- <<IS-END-IMPORTS>> ---

public final class utils

{
	// ---( internal utility methods )---

	final static utils _instance = new utils();

	static utils _newInstance() { return new utils(); }

	static utils _cast(Object o) { return (utils)o; }

	// ---( server methods )---




	public static final void utilAnyToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(utilAnyToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required AnyType
		// [o] field:0:required String
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	AnyType = IDataUtil.get( pipelineCursor, "AnyType" );
		pipelineCursor.destroy();
		// pipeline
		
		String string = AnyType.toString();
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "String", string );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void utilCopyFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(utilCopyFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required sourceFilename
		// [i] field:0:optional targetFilename
		// [i] field:0:required sourceDirectory
		// [i] field:0:required targetDirectory
		// [o] field:0:required message
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	sourceFilename = IDataUtil.getString( pipelineCursor, "sourceFilename" );
		String	targetFilename = IDataUtil.getString( pipelineCursor, "targetFilename" );
		String	sourceDirectory = IDataUtil.getString( pipelineCursor, "sourceDirectory" );
		String	targetDirectory = IDataUtil.getString( pipelineCursor, "targetDirectory" );
		pipelineCursor.destroy();
		// pipeline
		
		if(targetFilename == null)targetFilename = sourceFilename;
		if(targetDirectory == null)targetDirectory = sourceDirectory;
		
		FileChannel outChannel = null;
		FileChannel inChannel = null;  
		
		try {
			inChannel = new FileInputStream(new File(sourceDirectory, sourceFilename)).getChannel();
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();  
		}
		
		try {
			outChannel = new FileOutputStream(new File(targetDirectory, targetFilename)).getChannel();
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			// magic number for Windows, 64Mb - 32Kb)
		    int maxCount = (64 * 1024 * 1024) - (32 * 1024);
		    long size = inChannel.size();
		    long position = 0;
		    while (position < size) {
		       position += inChannel.transferTo(position, maxCount, outChannel);
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		}
		finally {
		    if (inChannel != null)
				try {
					inChannel.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		    if (outChannel != null)
				try {
					outChannel.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		// --- <<IS-END>> ---

                
	}



	public static final void utilDocumentToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(utilDocumentToString)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] record:0:required inputDocument
		// [i] field:0:optional removeEmpty {"false","true"}
		// [i] field:0:optional trimFields {"false","true"}
		// [o] record:0:required outputDocument
		// pipeline
		IDataCursor cursor = pipeline.getCursor();
		IData input = IDataUtil.getIData(cursor, "inputDocument");
		boolean trimFields = IDataUtil.getBoolean(cursor, "trimFields", false);
		IDataUtil.put(cursor, "outputDocument", documentToString(input, trimFields));
		cursor.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void utilGetCurrentPackageInfos (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(utilGetCurrentPackageInfos)>> ---
		// @sigtype java 3.5
		// [o] field:0:required packageName
		// [o] field:0:required packagePubFolderPath
		// [o] field:0:required packagePubFolderAbsolutePath
		//Get the packagename
		Stack callStack = com.wm.app.b2b.server.InvokeState.getCurrentState().getCallStack();
		com.wm.lang.ns.NSService caller = (com.wm.lang.ns.NSService)callStack.get(0);
		com.wm.lang.ns.NSPackage pkg = caller.getPackage();	
		
		com.wm.lang.ns.NSService nss = Service.getCallingService();
		String packageName = nss.getPackage().getName();
		if ("WmRoot".equals(packageName)) {
		       com.wm.app.b2b.server.InvokeState invokeState = com.wm.app.b2b.server.InvokeState
		                    .getCurrentState();
		       if (invokeState != null) {
		             com.wm.lang.flow.FlowState flowState = invokeState
		                           .getFlowState();
		             if (flowState != null) {
		                    com.wm.lang.flow.FlowElement flowElement = flowState
		                                  .current();
		                    if (flowElement != null) {
		                           com.wm.lang.flow.FlowElement flowRoot = flowElement
		                                         .getFlowRoot();
		                           String flowName = flowRoot.getNSName();
		                           com.wm.app.b2b.server.BaseService bs = com.wm.app.b2b.server.ns.Namespace
		                                         .getService(com.wm.lang.ns.NSName
		                                                       .create(flowName));
		                           packageName = bs.getPackageName();
		                    }
		             }
		       }
		}
		
		String applicationDir = System.getProperty("WM_HOME") + "packages/" + packageName + "/pub/" ; 
		applicationDir=applicationDir.replaceAll("\\\\", "/");
		applicationDir=applicationDir.replace("..", "");
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		IDataUtil.put( pipelineCursor, "packageName", packageName );
		IDataUtil.put( pipelineCursor, "packagePubFolderPath", "./packages/" + packageName + "/pub/" );
		IDataUtil.put( pipelineCursor, "packagePubFolderAbsolutePath", applicationDir);
		
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void utilStringToAny (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(utilStringToAny)>> ---
		// @sigtype java 3.5
		// [i] field:0:required string
		// [i] field:0:required type {"BigDecimal","BigInteger","Boolean","Character","Date","Double","Integer","Float","Long","MBoolean","MDouble","MFloat","MInteger","MLong","MShort","Object","Short"}
		// [i] field:0:optional dateFormat {"dd.MM.yyyy"}
		// [o] object:0:required AnyType
		// pipeline
		IDataCursor cursor = pipeline.getCursor();
		IData input = IDataUtil.getIData(cursor, "inputDocument");
		String string = IDataUtil.getString(cursor, "string");
		String type = IDataUtil.getString(cursor, "type");
		String dateFormat = IDataUtil.getString(cursor, "dateFormat");
		cursor.destroy();
		// pipeline	
		
		if (string == null || string.length() == 0)
		{
		  IDataUtil.put(cursor, "AnyType", null);
		}
		else if (type.equals("String"))
		{
		  IDataUtil.put(cursor, "AnyType", string);
		}
		else if (type.equals("Integer"))
		{
		  IDataUtil.put(cursor, "AnyType", new Integer(string));
		}
		else if (type.equals("MInteger"))
		{
		  IDataUtil.put(cursor, "AnyType", new MInteger(string));
		}
		else if (type.equals("Short"))
		{
		  IDataUtil.put(cursor, "AnyType", new Short(string));
		}
		else if (type.equals("MShort"))
		{
		  IDataUtil.put(cursor, "AnyType", new MShort(string));
		}
		else if (type.equals("Long"))
		{
		  IDataUtil.put(cursor, "AnyType", new Long(string));
		}
		else if (type.equals("MLong"))
		{
		  IDataUtil.put(cursor, "AnyType", new MLong(string));
		}
		else if (type.equals("Float"))
		{
		  IDataUtil.put(cursor, "AnyType", new Float(string));
		}
		else if (type.equals("MFloat"))
		{
		  IDataUtil.put(cursor, "AnyType", new MFloat(string));
		}
		else if (type.equals("Double"))
		{
		  IDataUtil.put(cursor, "AnyType", new Double(string));
		}
		else if (type.equals("MDouble"))
		{
		  IDataUtil.put(cursor, "AnyType", new MDouble(string));
		}
		else if (type.equals("Boolean"))
		{
		  IDataUtil.put(cursor, "AnyType", new Boolean(string));
		}
		else if (type.equals("MBoolean"))
		{
		  IDataUtil.put(cursor, "AnyType", new MBoolean(string));
		}
		else if (type.equals("BigDecimal"))
		{
		  IDataUtil.put(cursor, "AnyType", new BigDecimal(string));
		}
		else if (type.equals("BigInteger"))
		{
		  IDataUtil.put(cursor, "AnyType", new BigInteger(string));
		}
		else if (type.equals("Character"))
		{
			IDataUtil.put(cursor, "AnyType", new Character(string.charAt(0)));
		}
		else if (type.equals("Date"))
		{
			DateFormat df = new SimpleDateFormat(dateFormat);
			
			try {
				IDataUtil.put(cursor, "AnyType", df.parse(string));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{
		  throw new ServiceException("Dont know how to convert string to '" + type + "'");
		}
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static IData documentToString(IData inIData, boolean trimFields)
	{
	  IData outIData = IDataFactory.create();
	  IDataCursor outCursor = outIData.getCursor();
	  IDataCursor inCursor = inIData.getCursor();
	
	  while (inCursor.next())
	  {
	    Object obj = inCursor.getValue();
	    if (obj == null)
	    {
	      continue;
	    }
	
	    if (obj instanceof String)
	    {
	      String temp = (String) obj;
	      if (trimFields)
	      {
	        temp = temp.trim();
	      }
	
	      if (temp.length() > 0 )
	      {
	        IDataUtil.put(outCursor, inCursor.getKey(), temp);
	      }
	    }
	    else if (obj instanceof IData)
	    {
	      IData out = documentToString((IData) obj, trimFields);
	      if (out != null && out.getCursor().hasMoreData())
	      {
	        IDataUtil.put(outCursor, inCursor.getKey(), out);
	      }
	    }
	    else if (obj instanceof IData[])
	    {
	      IData[] objArray = (IData[]) obj;
	      ArrayList outArrayList = new ArrayList();
	
	      for (int i = 0; i < objArray.length; i++)
	      {
	        IData out = documentToString(objArray[i], trimFields);
	        if (out != null && out.getCursor().hasMoreData())
	        {
	          outArrayList.add(out);
	        }
	      }
	
	      IData[] outArray = null;
	      if (outArrayList.size() > 0)
	      {
	        outArray = new IData[outArrayList.size()];
	        outArrayList.toArray(outArray);
	        IDataUtil.put(outCursor, inCursor.getKey(), outArray);
	      }
	    }
	    else
	    {
	      IDataUtil.put(outCursor, inCursor.getKey(), obj.toString());
	    }
	  }
	  outCursor.destroy();
	  inCursor.destroy();
	  return outIData;
	}	
		
	// --- <<IS-END-SHARED>> ---
}

