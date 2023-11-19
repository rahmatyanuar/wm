package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.*;
import com.wm.util.*;
import java.io.*;
import java.util.*;
import java.text.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
// --- <<IS-END-IMPORTS>> ---

public final class date

{
	// ---( internal utility methods )---

	final static date _instance = new date();

	static date _newInstance() { return new date(); }

	static date _cast(Object o) { return (date)o; }

	// ---( server methods )---




	public static final void changeDateFormat (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(changeDateFormat)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inStringDate
		// [i] field:0:required currentFormat
		// [i] field:0:required newFormat
		// [o] field:0:required outStringDate
		IDataCursor pipelineCursor = pipeline.getCursor();
		String inStringDate = IDataUtil.getString( pipelineCursor, "inStringDate" );
		String currentFormat = IDataUtil.getString( pipelineCursor, "currentFormat" );
		String newFormat = IDataUtil.getString( pipelineCursor, "newFormat" );
		String outStringDate = "";
		
		try {
			if (inStringDate=="" || inStringDate == null) {				
				outStringDate = inStringDate;
			} else {
				Date inDate = new SimpleDateFormat(currentFormat).parse(inStringDate);
				SimpleDateFormat newDateFormat = new SimpleDateFormat(newFormat);
				outStringDate = newDateFormat.format(inDate);
				IDataUtil.put( pipelineCursor, "outStringDate", outStringDate);
			}
		} catch (Exception e) {			
			throw new ServiceException(e);
		} finally {
			pipelineCursor.destroy();
		}
		// --- <<IS-END>> ---

                
	}



	public static final void chkSMSTriggeredPeriod (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(chkSMSTriggeredPeriod)>> ---
		// @sigtype java 3.5
		// [i] field:0:required startTimestamp
		// [i] field:0:required endTimestamp
		// [i] field:0:required creationTimestamp
		// [i] field:0:required timestampFormat
		// [o] field:0:required status
	IDataCursor idcPipeline = pipeline.getCursor();
	String strStartDateTime = null;
	String strEndDateTime = null;
	String strCreationDateTime = null;
	String strDateFormat = null;
	
	if (idcPipeline.first("startTimestamp"))
		strStartDateTime = (String)idcPipeline.getValue();
	
	if (idcPipeline.first("endTimestamp"))
		strEndDateTime = (String)idcPipeline.getValue();

	if (idcPipeline.first("creationTimestamp"))
		strCreationDateTime = (String)idcPipeline.getValue();

	if (idcPipeline.first("timestampFormat"))
		strDateFormat = (String)idcPipeline.getValue();

	if (strStartDateTime.equals(""))
		throw new ServiceException("Start time for stop period must be supplied!");

	if (strEndDateTime.equals(""))
		throw new ServiceException("End time for stop period must be supplied!");
		
	if (strCreationDateTime.equals(""))
		throw new ServiceException("CreationTime must be supplied!");
				
	if (strDateFormat.equals(""))
		throw new ServiceException("strDateFormat must be supplied!");

	SimpleDateFormat sdfStart = new SimpleDateFormat(strDateFormat);
	SimpleDateFormat sdfEnd = new SimpleDateFormat(strDateFormat); 
	SimpleDateFormat sdfCreation = new SimpleDateFormat(strDateFormat);	 
	
	Date dStart = null;
	Date dEnd = null; 
	Date dCreation = null;  	  
	
	try
	{
		dStart = sdfStart.parse(strStartDateTime);
		dEnd = sdfEnd.parse(strEndDateTime); 
		dCreation = sdfCreation.parse(strCreationDateTime);		
	}
	catch (Exception e)
	{
		throw new ServiceException(e.toString());
	}

	boolean isWithin = ((dCreation.after(dStart)|| dCreation.equals(dStart)) && (dCreation.before(dEnd) || dCreation.equals(dEnd)));

	if (isWithin)
	{
		idcPipeline.insertAfter("status", "True");
	}
	else
	{
		idcPipeline.insertAfter("status", "False");
	}

	idcPipeline.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void compareGivenTimeStamp (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(compareGivenTimeStamp)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required timestamp1
		// [i] field:0:required timestamp2
		// [i] field:0:required timestampFormat
		// [o] field:0:required output
	IDataCursor idcPipeline = pipeline.getCursor();
	String strDateTime1 = null;
	String strDateTime2 = null;
	String strDateFormat = null;
	
	if (idcPipeline.first("timestamp1"))
		strDateTime1 = (String)idcPipeline.getValue();
	
	if (idcPipeline.first("timestamp2"))
		strDateTime2 = (String)idcPipeline.getValue();

	if (idcPipeline.first("timestampFormat"))
		strDateFormat = (String)idcPipeline.getValue();

	if (strDateTime1.equals(""))
		throw new ServiceException("Argument \"dateTime1\" must not be null.");
		
	if (strDateTime2.equals(""))
		throw new ServiceException("Argument \"dateTime2\" must not be null.");
				
	if (strDateFormat.equals(""))
		throw new ServiceException("dateTimeFormat must be supplied!");

	SimpleDateFormat sdfDT1 = new SimpleDateFormat(strDateFormat);
	SimpleDateFormat sdfDT2 = new SimpleDateFormat(strDateFormat); 
	
	Date dDT1 = null;
	Date dDT2 = null; 
	
	try
	{
		dDT1 = sdfDT1.parse(strDateTime1);
		dDT2 = sdfDT2.parse(strDateTime2); 
	}
	catch (Exception e)
	{
		throw new ServiceException(e.toString());
	}      
	
	int output = dDT1.compareTo(dDT2);	
	IDataUtil.put(idcPipeline, "output", String.valueOf(output));
	idcPipeline.destroy();   
		// --- <<IS-END>> ---

                
	}



	public static final void dateDifference (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateDifference)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required date1
		// [i] field:0:required date2
		// [o] field:0:required value
		IDataCursor idc = pipeline.getCursor();
		try{
		 String sysDate = IDataUtil.getString(idc,"date1");
		 String birthDate = IDataUtil.getString(idc,"date2");
		 DecimalFormat twoDForm = new DecimalFormat("#.#");
		
		 Date dtTmp1 = new SimpleDateFormat("dd-MM-yyyy").parse(sysDate);
		 Date dtTmp2 = new SimpleDateFormat("dd-MM-yyyy").parse(birthDate);
		 double dtTmp3 = dtTmp1.getTime()-dtTmp2.getTime(); //Get Date Difference in miliseconds
		 double dtTmp4 = dtTmp3/86400000; //Get Date Difference in days
		 double temp1 = dtTmp4/365;
		 Double dtTmp5 = Double.valueOf(twoDForm.format(dtTmp4/365)); //Get Date Difference in years
		 Double temp = Double.valueOf(twoDForm.format(temp1));
		    
		IDataUtil.put(idc, "value", String.valueOf(temp));
		 
		}catch (Exception exc) {
		throw new ServiceException(exc.toString());
		}
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void dateStrToEpochTime (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateStrToEpochTime)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required strDate
		// [i] field:0:required dateTimeFormat
		// [o] field:0:required epochTimeMs
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	strDate = IDataUtil.getString( pipelineCursor, "strDate" );
		String	dateTimeFormat = IDataUtil.getString( pipelineCursor, "dateTimeFormat" );
		
		try {
			SimpleDateFormat formatter = new SimpleDateFormat(dateTimeFormat);
			Date dateObj = formatter.parse(strDate);	
			IDataUtil.put( pipelineCursor, "epochTimeMs", Long.toString(dateObj.getTime()) );	
		}catch (Exception exc){
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void dateToStrArray_java (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateToStrArray_java)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:1:required javaDate
		// [i] field:0:required dateTimeFormat
		// [o] field:1:required strDate
		IDataCursor idc = pipeline.getCursor();
		
		try {
			Date[] javaDate = (Date[]) IDataUtil.getObjectArray(idc, "javaDate");
			String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			String[] outStr = new String[javaDate.length];
		
			for (int i=0; i < javaDate.length; i++) {
				outStr[i] = new String();
				outStr[i] = sdf.format(javaDate[i]);
			}
		
			IDataUtil.put(idc, "strDate", outStr);
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void dateToStr_java (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateToStr_java)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required javaDate
		// [i] field:0:required dateTimeFormat
		// [o] field:0:required strDate
		IDataCursor idc = pipeline.getCursor();
		
		try {
			Date javaDate = (Date) IDataUtil.get(idc, "javaDate");
			String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			String outStr = sdf.format(javaDate);
			IDataUtil.put(idc, "strDate", outStr);
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void epochTimeToDateStr (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(epochTimeToDateStr)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required epochTimeMs
		// [i] field:0:required dateTimeFormat
		// [o] field:0:required strDate
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	epochTime = IDataUtil.getString( pipelineCursor, "epochTimeMs" );
		String	dateTimeFormat = IDataUtil.getString( pipelineCursor, "dateTimeFormat" );
		
		try {
			Date dateObj = new Date(Long.parseLong(epochTime));
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			IDataUtil.put( pipelineCursor, "strDate", sdf.format(dateObj));
		}catch (Exception exc){
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void incrementDate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(incrementDate)>> ---
		// @sigtype java 3.5
		// [i] field:0:required startingDate
		// [i] field:0:required startingDateFormat
		// [i] field:0:required endingDateFormat
		// [i] field:0:optional addYears
		// [i] field:0:optional addMonths
		// [i] field:0:optional addDays
		// [i] field:0:optional addHours
		// [i] field:0:optional addMinutes
		// [i] field:0:optional addSeconds
		// [o] field:0:required endingDate

	IDataCursor idcPipeline = pipeline.getCursor();

	String strStartingDate = null;
	if (idcPipeline.first("startingDate"))
	{
		strStartingDate = (String)idcPipeline.getValue();
	}
	else 
	{
		throw new ServiceException("startingDate must be supplied!");
	}
	String strStartingDateFormat = null;
	if (idcPipeline.first("startingDateFormat"))
	{
		strStartingDateFormat = (String)idcPipeline.getValue();
	}
	else
	{
		throw new ServiceException("startingDateFormat must be supplied!");
	}
	String strEndingDateFormat = null;
	if (idcPipeline.first("endingDateFormat"))
	{
		strEndingDateFormat = (String)idcPipeline.getValue();
	}
	else
	{
		throw new ServiceException("endingDateFormat must be supplied!");
	}

	String strAddYears = null;
	String strAddMonths = null;
	String strAddDays = null;
	String strAddHours = null;
	String strAddMinutes = null;
	String strAddSeconds = null;

	if (idcPipeline.first("addYears"))
	{
		strAddYears = (String)idcPipeline.getValue();
	}
	if (idcPipeline.first("addMonths"))
	{
		strAddMonths = (String)idcPipeline.getValue();
	}
	if (idcPipeline.first("addDays"))
	{
		strAddDays = (String)idcPipeline.getValue();
	}
	if (idcPipeline.first("addHours"))
	{
		strAddHours = (String)idcPipeline.getValue();
	}
	if (idcPipeline.first("addMinutes"))
	{
		strAddMinutes = (String)idcPipeline.getValue();
	}
	if (idcPipeline.first("addSeconds"))
	{
		strAddSeconds = (String)idcPipeline.getValue();
	}

	SimpleDateFormat ssdf = new SimpleDateFormat(strStartingDateFormat);

	Date startingDate = null;
	try
	{
		startingDate = ssdf.parse(strStartingDate);
	}
	catch (Exception e)
	{
		throw new ServiceException(e.toString());
	}

	GregorianCalendar gc = new GregorianCalendar();
	gc.setTime(startingDate);

	if (strAddYears != null)
	{
		gc.add(Calendar.YEAR, Integer.parseInt(strAddYears));
	}
	if (strAddMonths != null)
	{
		gc.add(Calendar.MONTH, Integer.parseInt(strAddMonths));
	}
	if (strAddDays != null)
	{
		gc.add(Calendar.DAY_OF_MONTH, Integer.parseInt(strAddDays));
	}
	if (strAddHours != null)
	{
		gc.add(Calendar.HOUR_OF_DAY, Integer.parseInt(strAddHours));
	}
	if (strAddMinutes != null)
	{
		gc.add(Calendar.MINUTE, Integer.parseInt(strAddMinutes));
	}
	if (strAddSeconds != null)
	{
		gc.add(Calendar.SECOND, Integer.parseInt(strAddSeconds));
	}

	Date endingDate = gc.getTime();
	SimpleDateFormat esdf = new SimpleDateFormat(strEndingDateFormat);
	String strEndingDate = esdf.format(endingDate);

	idcPipeline.insertAfter("endingDate", strEndingDate);
	idcPipeline.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void strToDateArray_java (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(strToDateArray_java)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:1:required strDate
		// [i] field:0:required dateTimeFormat
		// [o] object:1:required javaDate
		IDataCursor idc = pipeline.getCursor();
		
		try {
			String[] strDate = IDataUtil.getStringArray(idc, "strDate");
			String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			Date[] outJava = new Date[strDate.length];
		
			for (int i=0; i < strDate.length; i++) {
				outJava[i] = new Date();
				outJava[i] = sdf.parse(strDate[i]);
			}
		
			IDataUtil.put(idc, "javaDate", outJava);
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void strToDate_java (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(strToDate_java)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required strDate
		// [i] field:0:required dateTimeFormat
		// [o] object:0:required javaDate
		IDataCursor idc = pipeline.getCursor();
		
		try {
			String strDate = IDataUtil.getString(idc, "strDate");
			String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			Date outJava = sdf.parse(strDate);
			IDataUtil.put(idc, "javaDate", outJava);
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void truncateDeliverDateTime (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(truncateDeliverDateTime)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required ddMMyyyy
		// [o] field:0:required hhmmss
		//Get input
		  IDataCursor idc = pipeline.getCursor();
		  Date javaDate = (Date) IDataUtil.get(idc, "replyDateTime");
		 
		  String ddMMyyyy = "";
		  String hhmmss = "";  
		
		try{ 
		    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		    DateFormat formatter1 = new SimpleDateFormat("HH:mm:ss");
		
		    ddMMyyyy = formatter.format((new Date(System.currentTimeMillis()))).toString();
		    hhmmss = formatter1.format((new Date(System.currentTimeMillis()))).toString();
		 
		}catch(Exception e){
		   throw new ServiceException(e.getMessage());
		}
		
		IDataUtil.put( idc, "ddMMyyyy", ddMMyyyy );
		IDataUtil.put( idc, "hhmmss", hhmmss );
		
		idc.destroy();
		
		// --- <<IS-END>> ---

                
	}
}

