package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-10 23:21:43 MYT
// -----( ON-HOST: maxis71

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class exec

{
	// ---( internal utility methods )---

	final static exec _instance = new exec();

	static exec _newInstance() { return new exec(); }

	static exec _cast(Object o) { return (exec)o; }

	// ---( server methods )---




	public static final void exec (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(exec)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required ExecCommand
		// [i] field:0:required TimeoutMS
		// [o] field:0:required CommandError
		// [o] field:0:required CommandOutput
		// [o] field:0:required CommandExitValue
		// [o] field:0:required StartDate
		// [o] field:0:required FinishDate
		// [o] field:0:required TimeoutStatus
		// abrightmoore@webmethods.com
		
		
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	ExecCommand = IDataUtil.getString( pipelineCursor, "ExecCommand" );
		long	Timeout = 60000;
		long SLEEP_TIME = 100;
		try
		{
			Timeout = Long.parseLong(IDataUtil.getString( pipelineCursor, "TimeoutMS" ));
		} catch(NumberFormatException e) {} 	// Timeout will stay at default
		if(Timeout <= 0) Timeout = 60000;   	// 1 Minute timeout by default. Don't allow 0 since
						   	// we aren't handling interaction with the process.
		pipelineCursor.destroy();
				 
		String err = "";
		String in = "";
		String endDate = "";
		String startDate = "";
		String exitValue = "";
		String TimeoutStatus = new Boolean(false).toString();
		long starttime = new java.util.Date().getTime();
				
		Runtime rt = Runtime.getRuntime();
		try
		{
			startDate = new java.util.Date().toString();
			Process p = rt.exec(ExecCommand);
			java.io.BufferedInputStream error = new java.io.BufferedInputStream(p.getErrorStream());
			java.io.BufferedInputStream input = new java.io.BufferedInputStream(p.getInputStream());
			java.io.BufferedOutputStream output = new java.io.BufferedOutputStream(p.getOutputStream());
				
			StringBuffer i = new StringBuffer();
			StringBuffer e = new StringBuffer();
				
			boolean keepGoing = true;
			while(keepGoing)
			{
				try
				{
					int proc_status = p.exitValue(); // throws exception if spawned proc still running
					keepGoing = false; // only executes once spawned proc has halted
					exitValue = new Integer(proc_status).toString();
				} catch(IllegalThreadStateException itse)
				{ // Spawned process is still running. Gather output for this example
					while(input.available() > 0)
						i.append((char)input.read());
				
					while(error.available() > 0)
						e.append((char)error.read());
									
					long now = new java.util.Date().getTime();
					if(now-starttime >= Timeout)
					{
						keepGoing = false;
						TimeoutStatus = new Boolean(true).toString();
					} else {
						// better sleep awhile so we don't peg out the CPU
						Thread.sleep(SLEEP_TIME);
					}
				}
			}
		
			// drain remaining text
			while(input.available() > 0)
				i.append((char)input.read());
			
			while(error.available() > 0)
				e.append((char)error.read());
		
			input.close();
			error.close();
			output.close();
			
			in=i.toString();
			err=e.toString();
				
			//			System.out.println("Waiting on process to die: "+p.waitFor());
			endDate = new java.util.Date().toString();
				
		} catch (Throwable t)
		{
			throw new ServiceException(t);
		}
				
			// pipeline
			IDataCursor pipelineCursor_1 = pipeline.getCursor();
			IDataUtil.put( pipelineCursor_1, "CommandError", err );
			IDataUtil.put( pipelineCursor_1, "CommandOutput", in );
			IDataUtil.put( pipelineCursor_1, "CommandExitValue", exitValue );
			IDataUtil.put( pipelineCursor_1, "StartDate", startDate );
			IDataUtil.put( pipelineCursor_1, "FinishDate", endDate );
			IDataUtil.put( pipelineCursor_1, "TimeoutStatus", TimeoutStatus );
			pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

