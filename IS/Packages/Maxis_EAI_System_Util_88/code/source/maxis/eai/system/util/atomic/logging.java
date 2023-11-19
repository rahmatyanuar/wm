package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-10 23:23:16 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.*;
import java.lang.SecurityException;
import java.util.Properties;
import com.wm.util.*;
// --- <<IS-END-IMPORTS>> ---

public final class logging

{
	// ---( internal utility methods )---

	final static logging _instance = new logging();

	static logging _newInstance() { return new logging(); }

	static logging _cast(Object o) { return (logging)o; }

	// ---( server methods )---




	public static final void writeToFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeToFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [i] field:0:required fileContent
		// [i] field:0:required overWrite {"false","true"}
		// [o] field:0:required successFlag
		//define input variables  
		IDataCursor idcPipeline = pipeline.getCursor();
		String strFilename = null;
		String strFileContent = null;
		String strOverwriteFlag = null;
		
		//Output Variables 
		String successFlag = "false";
		BufferedWriter fileWriter = null;
		
		// Check to see if the filename object is in the pipeline
		strFilename = IDataUtil.getString(idcPipeline, "filename");
		strFileContent = IDataUtil.getString(idcPipeline, "fileContent");;
		strOverwriteFlag = IDataUtil.getString(idcPipeline, "overWrite");;
		
		if (strFilename == null || strFileContent == null )
		{
			JournalLogger.logInfo(9998, 0, "Error executing sample.io.utils.fileWriter:openFileWriter: required parameter missing.");
			successFlag="false";
				
			//insert the successFlag into the pipeline
			idcPipeline.insertAfter("successFlag", successFlag);	
		
			//Always destroy cursors that you created
			idcPipeline.destroy();	
		
			return;
		}
		
		if (strOverwriteFlag == null)
			strOverwriteFlag = "false";
		
		try
		{
			// Try to create a BufferedWriter object.  Handle the exception if it fails.
			//Create a new BufferedWriter object that will append to the old file
			if (strOverwriteFlag.equals("true"))
				fileWriter = new BufferedWriter(new FileWriter(strFilename, false));
			else
				fileWriter = new BufferedWriter(new FileWriter(strFilename, true));
		
			// Try to write to the BufferedWriter object.  
			fileWriter.write(strFileContent);
		
			// Try to flush the fileWriter object.  
			fileWriter.flush();
		
			// Try to close the fileWriter object.  
			fileWriter.close();
		
			//Set the success flag because the service was successful
			successFlag = "true";
		}
		catch (Exception e)
		{
			//Set the success flag because the service failed
			successFlag = "false";
		
			//Print the exception out to standard output
			JournalLogger.logInfo(9998, 0, "Error occurred during writing to log file: " + e.toString());	
		}
		
		
		//insert the successFlag into the pipeline
		idcPipeline.insertAfter("successFlag", successFlag);
		
		//Always destroy cursors that you created
		idcPipeline.destroy();	
		// --- <<IS-END>> ---

                
	}



	public static final void writeToFileWithHeader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeToFileWithHeader)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [i] field:0:required fileContent
		// [i] field:0:required overWrite {"false","true"}
		// [i] field:0:required header
		// [o] field:0:required successFlag
		//define input variables  
		IDataCursor idcPipeline = pipeline.getCursor();
		String strFilename = null;
		String strFileContent = null;
		String strOverwriteFlag = null;
		String header = null;
		
		//Output Variables 
		String successFlag = "false";
		BufferedWriter fileWriter = null;
		
		// Check to see if the filename object is in the pipeline
		strFilename = IDataUtil.getString(idcPipeline, "filename");
		strFileContent = IDataUtil.getString(idcPipeline, "fileContent");
		strOverwriteFlag = IDataUtil.getString(idcPipeline, "overWrite");
		header = IDataUtil.getString(idcPipeline, "header");
		
		if (strFilename == null || strFileContent == null )
		{
			JournalLogger.logInfo(9998, 0, "Error executing maxis.eai.system.util.atomic.logging:writeToFileWithHeader required parameter missing.");
			successFlag="false";
				
			//insert the successFlag into the pipeline
			idcPipeline.insertAfter("successFlag", successFlag);	
		
			//Always destroy cursors that you created
			idcPipeline.destroy();	
		
			return;
		}
		
		if (strOverwriteFlag == null)
			strOverwriteFlag = "false";
		
		try
		{
			// Write the header if the file is created for the first time.
			boolean addHeader = false;
			if (!(new File(strFilename)).exists())
				addHeader = true;
		
			// Try to create a BufferedWriter object.  Handle the exception if it fails.
			//Create a new BufferedWriter object that will append to the old file
			if (strOverwriteFlag.equals("true"))
				fileWriter = new BufferedWriter(new FileWriter(strFilename, false));
			else
				fileWriter = new BufferedWriter(new FileWriter(strFilename, true));
		
			if (addHeader)
				fileWriter.write(header+"\n");
		
			// Try to write to the BufferedWriter object.  
			fileWriter.write(strFileContent+"\n");
		
			// Try to flush the fileWriter object.  
			fileWriter.flush();
		
			// Try to close the fileWriter object.  
			fileWriter.close();
		
			//Set the success flag because the service was successful
			successFlag = "true";
		}
		catch (Exception e)
		{
			//Set the success flag because the service failed
			successFlag = "false";
		
			//Print the exception out to standard output
			JournalLogger.logInfo(9998, 0, "Error occurred in maxis.eai.system.util.atomic.logging:writeToFileWithHeader during writing to log file: " + e.toString());	
		}
		
		
		//insert the successFlag into the pipeline
		idcPipeline.insertAfter("successFlag", successFlag);
		
		//Always destroy cursors that you created
		idcPipeline.destroy();	
		// --- <<IS-END>> ---

                
	}
}

