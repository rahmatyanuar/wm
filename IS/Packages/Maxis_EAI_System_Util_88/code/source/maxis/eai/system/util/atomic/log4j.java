package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.Hashtable;
import java.util.Properties;
import java.text.SimpleDateFormat;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.LoggerContext;
import com.wm.app.b2b.server.ServerAPI;
import com.wm.app.b2b.server.ListenerAdmin;
import com.wm.app.b2b.server.ServerListenerIf;
import com.wm.lang.ns.NSName;
import com.wm.lang.ns.NSService;
import com.wm.app.b2b.server.InvokeState;
import java.util.Stack;
// --- <<IS-END-IMPORTS>> ---

public final class log4j

{
	// ---( internal utility methods )---

	final static log4j _instance = new log4j();

	static log4j _newInstance() { return new log4j(); }

	static log4j _cast(Object o) { return (log4j)o; }

	// ---( server methods )---




	public static final void reLoadLog4jConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(reLoadLog4jConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		loadLog4J2XmlConfig();
		// --- <<IS-END>> ---

                
	}



	public static final void writeEventLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeEventLog)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required application
		// [i] field:0:optional loggingLevel {"Fatal","Error","Warn","Info","Debug","Trace","Off"}
		// [i] field:0:optional serviceName
		// [i] field:0:required logEntry
		// [i] field:0:optional inputFieldsInfo
		// [o] field:0:required status
		IDataCursor pipelineCursor = null;
		pipelineCursor = pipeline.getCursor();
			
		String application = IDataUtil.getString(pipelineCursor, "application");//ie: esmeLogger, then the application= "esme"
		String loggingLevel = IDataUtil.getString(pipelineCursor, "loggingLevel");
		String serviceName = IDataUtil.getString(pipelineCursor, "serviceName");
		String logEntry = IDataUtil.getString(pipelineCursor, "logEntry");
		String inputFieldsInfo = IDataUtil.getString(pipelineCursor, "inputFieldsInfo");
		String status ="Success";
			
		try {				
			String loggerName = application + "_" + HOST_NAME + "_" + IS_PRIMARY_PORT;
			Logger logger = LogManager.getLogger(loggerName);
				
			//To check whether the logger is in log4j2 xml configuraton or not
			//For ROOT logger we will set to OFF, hence if we get OFF, the logger is not in configuration
			if (logger.getLevel().toString().equalsIgnoreCase("OFF")){
				throw new IllegalArgumentException(loggerName + " logger is null. Please check your Log4jProperties file!");
			}	
			
			//Make sure logEntry is not null
			if (logEntry == null){
				throw new IllegalArgumentException("logEntry is null");
			}
				
			//If loggingLevel is not being passed in, default to INFO		
			if (loggingLevel == null){
				loggingLevel = LEVEL_INFO;
			}
		
			//If serviceName is not being passed in, try to get it programmatically			
			if (serviceName == null){
				NSService currentSvc = Service.getServiceEntry();
				Stack callStack = InvokeState.getCurrentState().getCallStack();
				int index = callStack.indexOf(currentSvc);
				if (index > 1){  
					serviceName=((NSService) callStack.elementAt(index - 2)).toString();
				} else {
					serviceName=((NSService) callStack.elementAt(index - 1)).toString();
				}
			}
		
			//inputFieldsInfo 			
			if (inputFieldsInfo == null){
				inputFieldsInfo = "";
			}
			
			//Format message that will be logged
			String logMsg = "[" + serviceName + "] "+ logEntry + ". " + inputFieldsInfo;
		
			//do the logging
			if (loggingLevel.equalsIgnoreCase(LEVEL_FATAL))
				logger.fatal(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_ERROR))
				logger.error(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_WARN))
				logger.warn(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_INFO))
				logger.info(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_DEBUG))
				logger.debug(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_TRACE))
				logger.trace(logMsg);
		
		} catch (Throwable t) {
			debugLog("Exception - " + t.getMessage(), "Maxis_EAI_System_Util_88/maxis.eai.system.util.atomic.log4j:writeEventLog", "Error");				
			status = t.getMessage() ;
		} finally {
			IDataUtil.put(pipelineCursor, "status", status);
			if (pipelineCursor != null) pipelineCursor.destroy();
		}	
		// --- <<IS-END>> ---

                
	}



	public static final void writeTextLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeTextLog)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required application
		// [i] field:0:required logMsg
		// [i] field:0:optional loggingLevel {"Fatal","Error","Warn","Info","Debug","Trace","Off"}
		IDataCursor pipelineCursor = null;
		pipelineCursor = pipeline.getCursor();
			
		String application = IDataUtil.getString(pipelineCursor, "application");//ie: esmeLogger, then the application= "esme"
		String logMsg = IDataUtil.getString(pipelineCursor, "logMsg");
		String loggingLevel = IDataUtil.getString(pipelineCursor, "loggingLevel");			
		String status ="Success";
			
		try {				
			String loggerName = application + "_" + HOST_NAME + "_" + IS_PRIMARY_PORT;
			Logger logger = LogManager.getLogger(loggerName);
				
			//To check whether the logger is in log4j2 xml configuraton or not
			//For ROOT logger we will set to OFF, hence if we get OFF, the logger is not in configuration
			if (logger.getLevel().toString().equalsIgnoreCase("OFF")){
				throw new IllegalArgumentException(loggerName + " logger is null. Please check your Log4jProperties file!");
			}	
				
			//If loggingLevel is not being passed in, default to INFO		
			if (loggingLevel == null){
				loggingLevel = LEVEL_INFO;
			}
		
			//logMsg 			
			if (logMsg == null){
				logMsg = "";
			}
		
			//do the logging
			if (loggingLevel.equalsIgnoreCase(LEVEL_FATAL))
				logger.fatal(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_ERROR))
				logger.error(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_WARN))
				logger.warn(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_INFO))
				logger.info(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_DEBUG))
				logger.debug(logMsg);
			else if (loggingLevel.equalsIgnoreCase(LEVEL_TRACE))
				logger.trace(logMsg);
		
		} catch (Throwable t) {
			debugLog("Exception - " + t.getMessage(), "Maxis_EAI_System_Util_88/maxis.eai.system.util.atomic.log4j:writeEventLog", "Error");				
			status = t.getMessage() ;
		} finally {
			IDataUtil.put(pipelineCursor, "status", status);
			if (pipelineCursor != null) pipelineCursor.destroy();
		}	
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static final String PKG_NAME = "Maxis_EAI_System_Admin_Config_00";//package where we stored all XML configuration
	private static final String LOG4J_PROPERTIES_FILE = ServerAPI.getPackageConfigDir(PKG_NAME).getAbsolutePath() + System.getProperty("file.separator") + "Maxis_Log4jProperties.properties";
	//private static final String IS_PRIMARY_PORT = ListenerAdmin.getPrimaryListener().getProperties().getString("port").trim();
	private static  String IS_PRIMARY_PORT = "";
	private static final String HOST_NAME = ServerAPI.getServerName();
		
	private static final String LEVEL_OFF = "Off";
	private static final String LEVEL_TRACE = "Trace";
	private static final String LEVEL_DEBUG = "Debug";
	private static final String LEVEL_INFO = "Info";
	private static final String LEVEL_WARN = "Warn";
	private static final String LEVEL_ERROR = "Error";
	private static final String LEVEL_FATAL = "Fatal";
	
	//to load the log4j2 xml configuration file
	public static void loadLog4J2XmlConfig(){		
		try {
			System.setProperty("Log4jContextSelector", "org.apache.logging.log4j.core.async.AsyncLoggerContextSelector");
			LoggerContext context = (org.apache.logging.log4j.core.LoggerContext) LogManager.getContext(false);
			File file = new File(LOG4J_PROPERTIES_FILE);			
			context.setConfigLocation(file.toURI());	
			debugLog("Log4J2 initialized", "loadLog4J2XmlConfig", "Info");
		} catch (Exception ex) {
			debugLog("Fail to initialize Log4J2 [" + ex.getMessage() + "]", "loadLog4J2XmlConfig", "Error");			
		} 
	}
	
	//to invoke pub.flow:debugLog
	private static void debugLog(String message, String function, String level){
		IData input = null;
		IDataCursor inputCursor = null;
		IData output = null;	
		try {
			input = IDataFactory.create();
			inputCursor = input.getCursor();
			if (message != null)
				IDataUtil.put(inputCursor, "message", message);
			if (function != null)
				IDataUtil.put(inputCursor, "function", function);
			if (level != null)
				IDataUtil.put(inputCursor, "level", level);
			output = IDataFactory.create();
			output = Service.doInvoke("pub.flow", "debugLog", input);
		} catch (Throwable t) {
			// do nothing
		} finally {
			if (inputCursor != null)
				inputCursor.destroy();
		}
	}
	
	//load the log4j2 xml configuration when the class is loading
	static{
		//try to get the primary listener port from server.cnf
		try{
			Properties prop = new Properties();  
			prop.load(new FileInputStream(ServerAPI.getServerConfigDir() + System.getProperty("file.separator") + "server.cnf"));  
			IS_PRIMARY_PORT = prop.getProperty("watt.server.port");
			prop = null;
		}catch (Exception e){
			debugLog("Fail to get primary port info [" + e.getMessage() + "]", "loadLog4J2XmlConfig", "Error");				
		}
		loadLog4J2XmlConfig();
	}
	// --- <<IS-END-SHARED>> ---
}

