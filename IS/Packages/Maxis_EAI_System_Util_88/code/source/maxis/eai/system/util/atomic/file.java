package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.*;
import java.util.*;
import java.text.*;
import java.lang.SecurityException;
import com.wm.util.Debug;
import java.util.Properties;
import com.wm.app.b2b.server.*;
import com.googlecode.compress_j2me.lzc.LZCInputStream;
// --- <<IS-END-IMPORTS>> ---

public final class file

{
	// ---( internal utility methods )---

	final static file _instance = new file();

	static file _newInstance() { return new file(); }

	static file _cast(Object o) { return (file)o; }

	// ---( server methods )---




	public static final void copyFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(copyFile)>> ---
		// @sigtype java 3.5
		// [i] record:0:required copyFileInput
		// [i] - field:0:required sourceFile
		// [i] - field:0:required destinationFile
		// [o] record:0:required copyFileOutput
		// [o] - field:0:required msgCode
		// [o] - field:0:required msgDesc
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData copyFileInput = IDataUtil.getIData( pipelineCursor, "copyFileInput" );
		String	sourceFile = null;
		String	destinationFile = null;
		if ( copyFileInput != null){
			IDataCursor copyFileInputCursor = copyFileInput.getCursor();
			sourceFile = IDataUtil.getString( copyFileInputCursor, "sourceFile" );
			destinationFile = IDataUtil.getString( copyFileInputCursor, "destinationFile" );
			copyFileInputCursor.destroy();
		}
		
		InputStream is = null;
		OutputStream os = null;
		String msgCode = "0";
		String msgDesc = "success";
		try {
		    is = new FileInputStream(sourceFile);
		    os = new FileOutputStream(destinationFile);
		    byte[] buffer = new byte[1024];
		    int length;
		    while ((length = is.read(buffer)) > 0) {
		        os.write(buffer, 0, length);
		    }
		} catch(Exception e){ 
			msgCode = "2";
			msgDesc = e.getMessage();
		} finally {
			try {
				is.close();
				os.close();
			}catch(Exception e){}
		}
		
		IData	copyFileOutput = IDataFactory.create();
		IDataCursor copyFileOutputCursor = copyFileOutput.getCursor();
		IDataUtil.put( copyFileOutputCursor, "msgCode", msgCode );
		IDataUtil.put( copyFileOutputCursor, "msgDesc", msgDesc );
		copyFileOutputCursor.destroy();
		IDataUtil.put( pipelineCursor, "copyFileOutput", copyFileOutput );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void deleteFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [i] field:0:required directory
		// [o] field:0:required successFlag
		 
		//define input variables
		IDataCursor idcPipeline = pipeline.getCursor();
		String longFilename,filename,directory ;
		
		//Output Variables
		String successFlag = "false";
		
		// Check to see if the filename object is in the pipeline
		if (idcPipeline.first("filename"))
		{
			//get the filename string object out of the pipeline
			filename = (String) idcPipeline.getValue();
		}
		//if it is not in the pipeline, then handle the error
		else
		{
			successFlag="false";
			//insert the successFlag into the pipeline
			idcPipeline.insertAfter("successFlag", successFlag);
		
			//Always destroy cursors that you created
			idcPipeline.destroy();
			return;
		}
		
		// Check to see if the directory object is in the pipeline
		if (idcPipeline.first("directory"))
		{
			//get the directory string object out of the pipeline
			directory = (String) idcPipeline.getValue();
		}
		//if it is not in the pipeline, then handle the error
		else
		{
			successFlag="false";
		
			//insert the successFlag into the pipeline
			idcPipeline.insertAfter("successFlag", successFlag);
		
			//Always destroy cursors that you created
			idcPipeline.destroy();
		
			return;
		}
		
		//Check if a directory was entered
		if (directory == null)
		{
				longFilename = (filename);
		}
		else
		{
			longFilename = (directory + "/" + filename);
		}
		
		//Assign full path name to a file object
		File localFile = new File(longFilename);
		
		//Try to delete the file
		try
		{
			//Check is a directory was entered
			if (localFile.isDirectory())
			{
				Debug.log(1,"Error executing sample.io.utils:deleteFile: Can't delete a directory" );
				successFlag = "false";
			}
			//Check if the file doesn't exist
			else if (!localFile.exists())
			{
				Debug.log(1,"Error executing sample.io.utils:deleteFile: File does not exist" );
				successFlag = "false";
		
			}
			//check if you can write to file
			else if (!localFile.canWrite()) 
			{
				Debug.log(1,"Error executing sample.io.utils:deleteFile: File not writeable");
				successFlag = "false";
		
			}
			//File can be deleted
			else
			{
			localFile.delete();
			successFlag = "true";
			}
		}
		//Catch any other error's
		catch (Exception e)
		{
			Debug.log(1,"Error executing sample.io.utils:deleteFile:" + e.toString());
			successFlag = "false";
		}
		//insert the successFlag into the pipeline
		idcPipeline.insertAfter("successFlag", successFlag);
		
		//Always destroy cursors that you created
		idcPipeline.destroy();
			
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
		String[] 	sfn = null, 	// abstract file names
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



	public static final void fileToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(fileToString)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required fileName
		// [i] field:0:optional toStringList {"YES","NO"}
		// [o] field:1:required fileContent
		// pipeline - in
		IDataCursor pc = pipeline.getCursor();
		String	fileName = IDataUtil.getString( pc, "fileName" );
		String  toStringList = IDataUtil.getString( pc, "toStringList" );
		String  fileContent = null, cline;
		boolean mklist = false;
		Vector v = new Vector();
		BufferedReader in = null;
		String[] sc = null;
		
		try{
			if(toStringList.equals("YES")) mklist = true;
		
			in = new BufferedReader(new FileReader(fileName));
		
			while(true){
				if( (cline = in.readLine()) == null) break;
				
				if( fileContent == null )
					if(mklist)
						v.add(cline);
					else
						fileContent = cline;
				else
					if(mklist)
						v.add(cline);
					else{
						fileContent = fileContent + "\n" + cline;
					}
			}
			try{ // file contents
				sc = new String[v.size()];
				for(int x = 0; x < v.size(); x++)
				sc[x] = (String)v.elementAt(x);
			}catch(Exception e){}
		}
		catch(Exception e){
			// do nothing
		}
		finally{ 
			try{
				in.close();
			}catch(Exception e)
			{}
		}
		
		// pipeline - out
		if(mklist)
			IDataUtil.put( pc, "fileContent", sc );
		else
			IDataUtil.put( pc, "fileContent", fileContent );
		pc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void fileType (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(fileType)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [o] field:0:required successFlag
		// [o] field:0:required exists
		// [o] field:0:required fileType
		 
		//define input variables
		IDataCursor idcPipeline = pipeline.getCursor();
		String filename = null ;
		
		//Output Variables
		String successFlag = "false";
		String exists = null;
		String fileType = null;
		
		// Check to see if the filename object is in the pipeline
		if (idcPipeline.first("filename"))
		{
			//get the filename string object out of the pipeline
			filename = (String) idcPipeline.getValue();
		}
		//if it is not in the pipeline, then handle the error
		else
		{
			System.out.println("Error executing sample.io.fileExists: Required parameter 'filename' missing.");
			successFlag="false";
		
			//insert the successFlag into the pipeline
			idcPipeline.insertAfter("successFlag", successFlag);
		
			//Always destroy cursors that you created
			idcPipeline.destroy();
		
			return;
		}
		
		//Assign file or directory name to a file object
		File fileOrDir = new File(filename);
		
		//Check if the object exists
		if (fileOrDir.exists())
		{
			// Check if the filename is an actual directory
		 	if (fileOrDir.isDirectory())
			{
				successFlag = "true";
				exists = "true";
				fileType = "directory";
			}
		
			//The filename is a name of an actual file
			else
			{
				successFlag = "true";
				exists = "true";
				fileType = "file";
			}
		}
		//File doesn't exist
		else
		{
			successFlag = "true";
			exists = "false";
			fileType = null;
		}
		
		
		//insert the successFlag into the pipeline
		idcPipeline.insertAfter("successFlag", successFlag);
		
		//insert the exists of file into the pipline
		idcPipeline.insertAfter("exists", exists);
		
		//insert the type of file into the pipline
		idcPipeline.insertAfter("fileType", fileType);
		
		//Always destroy cursors that you created
		idcPipeline.destroy();
		
		// --- <<IS-END>> ---

                
	}



	public static final void getFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [o] object:0:required bytes
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	filename = IDataUtil.getString( pipelineCursor, "filename" );
		FileInputStream fin = null;
		
		try{
			File f = new File(filename);
			fin = new FileInputStream(f);
			byte[] bytes = toByteArray(fin); 
			IDataUtil.put( pipelineCursor, "bytes", bytes );
		}catch(Exception e){
			throw new ServiceException(e);
		}finally{
			pipelineCursor.destroy();	
			if(fin != null){
				try{
					fin.close();
				}catch(Exception e){}
			}
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getFileNameTimestamp (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileNameTimestamp)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required outputTimeFormat
		IDataCursor idc = pipeline.getCursor();
		Date inputDate = new Date();
		Date outputDate = new Date();
		String strOutputDate="";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
		
		try{
			// to set year, month, date, hour, seconds
			outputDate.setYear(inputDate.getYear());
			outputDate.setMonth(inputDate.getMonth());
			outputDate.setDate(inputDate.getDate());
			outputDate.setHours(inputDate.getHours());
			outputDate.setSeconds(00);
			
			if ((inputDate.getMinutes() >=00 ) && (inputDate.getMinutes()<=30)) {
				outputDate.setMinutes(30);
			}else{
				outputDate.setMinutes(00);
				outputDate.setHours(outputDate.getHours()+1);
			}		
			strOutputDate = dateFormat.format(outputDate);
			IDataUtil.put(idc, "outputTimeFormat", strOutputDate);
		}catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}finally{
			idc.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getFileSeparator (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getFileSeparator)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required fileSeparator
		IDataCursor pipelineCursor = pipeline.getCursor();
		IDataUtil.put( pipelineCursor, "fileSeparator", File.separator );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void listFilesWithRegexFilter (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(listFilesWithRegexFilter)>> ---
		// @sigtype java 3.5
		// [i] field:0:required directory
		// [i] field:0:required filter
		// [o] field:1:required fileList
		// [o] field:0:required numFiles
		// pipeline
		
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	directory = IDataUtil.getString( pipelineCursor, "directory" );
		String	filter = IDataUtil.getString( pipelineCursor, "filter" );
		File dir = new File(directory);
		if (! dir.exists() || dir.isFile()){
			throw new ServiceException("Directory " + directory + " does not exist.");
		}
		if(filter == null || filter.trim().equals("")){
			String files[] = dir.list();
			IDataUtil.put( pipelineCursor, "fileList", files);
			IDataUtil.put( pipelineCursor, "numFiles", files.length);
		} else {
			String files[] = dir.list(new RegexFileNameFilter(filter));
			IDataUtil.put( pipelineCursor, "fileList", files);
			IDataUtil.put( pipelineCursor, "numFiles", files.length);
		}
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void lzcUncompress (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(lzcUncompress)>> ---
		// @sigtype java 3.5
		// [i] record:0:required decompressInput
		// [i] - field:0:required srcFileNameFullPath
		// [i] - field:0:required targetFileNameFullPath
		IDataCursor pipelineCursor = pipeline.getCursor();
		IData decompressInput = IDataUtil.getIData( pipelineCursor, "decompressInput" );
		String srcFileNameFullPath = null;
		String targetFileNameFullPath = null;
		if (decompressInput != null){
			IDataCursor decompressInputCursor = decompressInput.getCursor();
			srcFileNameFullPath = IDataUtil.getString( decompressInputCursor, "srcFileNameFullPath" );
			targetFileNameFullPath = IDataUtil.getString( decompressInputCursor, "targetFileNameFullPath" );
			decompressInputCursor.destroy();
		}
		pipelineCursor.destroy();
		
		if(srcFileNameFullPath == null || srcFileNameFullPath.trim().equals("")){
			throw new ServiceException("srcFileNameFullPath is mandatory");
		}
		
		if(targetFileNameFullPath == null || targetFileNameFullPath.trim().equals("")){
			throw new ServiceException("targetFileNameFullPath is mandatory");
		}
		
		LZCInputStream in = null;
		FileOutputStream fos = null;
		byte[] buffer = new byte[1024];
		try{
			in = new LZCInputStream(new FileInputStream(srcFileNameFullPath));
			fos = new FileOutputStream(targetFileNameFullPath);
			int len;
			while ((len = in.read(buffer)) > 0) {
				fos.write(buffer, 0, len);
			}
		}catch(Exception e){
			throw new ServiceException(e);
		}finally{
			if(in != null){
				try{
					in.close();
				}catch(IOException ioe){}
			}
			
			if(fos != null){
				try{
					fos.close();
				}catch(IOException ioe2){}
			}
		}
		// --- <<IS-END>> ---

                
	}



	public static final void makeDir (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeDir)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required dir
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	dir = IDataUtil.getString( pipelineCursor, "dir" );
		pipelineCursor.destroy();
		int x = 0;
		 
		try{
		 
			File dirPath = new File(dir);
		
			while(true){
		
				if( x > 3 ) break;
		
				if ( dirPath.exists() ) { 
					break;
				}
				else {
				    if ( dirPath.mkdirs() ){
						break;
					} else {}
				}
				Thread.sleep(2000);
				
				x++;
			}
		}
		catch(Exception e){}
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
		// [i] field:0:required overwriteFlag {"true","false"}
		// [o] field:0:required status
		// pipeline - in
		IDataCursor pc = pipeline.getCursor();
		String	moveFrom = IDataUtil.getString( pc, "moveFrom" );
		String	moveTo = IDataUtil.getString( pc, "moveTo" );
		String  overwriteFlag=  IDataUtil.getString( pc, "overwriteFlag" );
		File sourceFile, targetFile = null;
		boolean result;
		String status = "FAILED";
		
		try{
			sourceFile = new File(moveFrom);	// source file
			targetFile = new File(moveTo);	// target file
			
			if(sourceFile.exists())
			{			// check whether source file exists
				if(targetFile.exists())
				{	
					if(overwriteFlag.equals("false"))
					{
						// check whether target file exists
						status = "File already exists in target directory!";
					}
					else
					{
						sourceFile.renameTo(targetFile);
						status = "OK";
					}
				}
				else
				{
					result = sourceFile.renameTo(targetFile);	// check whether moving file was successful
					Debug.log(1,"SourceFile="+ sourceFile + " and TargetFile ="+ targetFile);
					if (result == true)
					status = "OK";
				}
			}
			else
			{
				status = sourceFile + " does not exist!";
			}
		}
		catch(Exception exc)
		{
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		// pipeline - out
		IDataUtil.put( pc, "status", status );
		pc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void moveFileByOSCommand (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(moveFileByOSCommand)>> ---
		// @sigtype java 3.5
		// [i] field:0:required moveFromDir
		// [i] field:0:required moveToDir
		// [i] field:0:required fileName
		// [o] field:0:required status
		// [o] field:0:required output
		// [o] field:0:required error
	IDataCursor idcPipeline = pipeline.getCursor();
	String strOutput = "";
	String strError = "";
	String strCommand = null;
	String moveFromDir = IDataUtil.getString(idcPipeline  , "moveFromDir" );
	String moveToDir = IDataUtil.getString( idcPipeline, "moveToDir" );
	String fileName =  IDataUtil.getString( idcPipeline, "fileName" );
	String strSynchronous="true";
	File sourceFile, targetFileDir = null;
	
	Process process = null;
	try
	{
		sourceFile = new File(moveFromDir +"/"+ fileName);	
		targetFileDir = new File(moveToDir);
		
		//to check whether source file is executed or not
		if(!sourceFile.exists())
		{
		    throw new ServiceException("[moveFileByOSCommand] Invalid Source File Name "+ moveFromDir);
		}
		//Debug.log (1, "Stage 1");
		//to check distination directory
		if(!targetFileDir.exists())
		{
		    throw new ServiceException("[moveFileByOSCommand] Invalid Target Directory"+ moveToDir);
		}

		// prepare Move Command
		strCommand = "mv "+ moveFromDir+"/"+fileName+" "+moveToDir+"/"+fileName;
		//sDebug.log (1, "Move Command = "+ strCommand);

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
			idcPipeline.insertAfter("status", Integer.toString(status));
		}
		idcPipeline.insertAfter("output", strOutput);
		idcPipeline.insertAfter("error", strError);
		process.destroy();
		idcPipeline.destroy();
	}
		// --- <<IS-END>> ---

                
	}



	public static final void renameFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(renameFile)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required OldFileName
		// [i] field:0:required NewFileName
		// [o] field:0:required Status
		// [o] field:0:required Message
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	oldFileName = IDataUtil.getString( pipelineCursor, "OldFileName" );
		String	newFileName = IDataUtil.getString( pipelineCursor, "NewFileName" );
		pipelineCursor.destroy();
		 
		//rename File
		 String result="";
		 String strMessage="";
		 String data;
		  		try
				{
					RandomAccessFile raf= new RandomAccessFile(oldFileName,"r");
					FileOutputStream fos=new FileOutputStream(newFileName);
					PrintWriter out = new PrintWriter(fos,true);
					while((data=raf.readLine())!=null)
					{
						out.println(data);
					}
					out.flush();
				        out.close();
					raf.close();
					fos.close();
					File file= new File(oldFileName);
					result="T";
				}
				catch(Exception e)
				{
					result="F";
					strMessage=e.getMessage();
				}
		 
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "Status", result);
		IDataUtil.put( pipelineCursor_1, "Message", strMessage );
		pipelineCursor_1.destroy();
		
		// --- <<IS-END>> ---

                
	}



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
			Debug.log(1, "Error: required parameter missing.");
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
			//Debug.log(1,"Success return");
		}
		catch (Exception e)
		{
			//Set the success flag because the service failed
			successFlag = "false";
		
			//Print the exception out to standard output
			Debug.log(1, "Error occurred during writing to log file: " + e.toString());	
		}
		
		
		//insert the successFlag into the pipeline
		idcPipeline.insertAfter("successFlag", successFlag);
		
		//Always destroy cursors that you created
		idcPipeline.destroy();	
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;
	
	public static byte[] toByteArray(InputStream input) throws IOException {
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		copy(input, output);
		return output.toByteArray();
	}
	
	public static int copy(InputStream input, OutputStream output) throws IOException {
		long count = copyLarge(input, output);
	    if (count > Integer.MAX_VALUE) {
	    	return -1;
	    }
	    return (int) count;
	}
	
	public static long copyLarge(InputStream input, OutputStream output)
	            throws IOException {
		byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
	    long count = 0;
	    int n = 0;
	    while (-1 != (n = input.read(buffer))){
	    	output.write(buffer, 0, n);
	    	count += n;
	    }
	    return count;
	}
	
	public static class RegexFileNameFilter implements FilenameFilter {
	    private String regexFilterStr = null;
		
	    public RegexFileNameFilter(String regexFilterStr) {
	       this.regexFilterStr = regexFilterStr;
	    }
	    
	    @Override
	    public boolean accept(File dir, String name) {
	    	String dirStr = dir.getAbsolutePath();
	    	if(new File(dirStr + File.separator + name).isDirectory()){
	    		return false;
	    	} else {
	    		if(name.matches(regexFilterStr)){
	    			return true;
	    		} else {
	    			return false;
	    		} 
	    	}
	    }
	}
	// --- <<IS-END-SHARED>> ---
}

