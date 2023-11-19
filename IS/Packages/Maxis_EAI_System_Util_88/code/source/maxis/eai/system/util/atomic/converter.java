package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.server.ServerAPI;
import java.text.SimpleDateFormat;
import java.util.*;
import java.math.BigDecimal;
import java.math.BigInteger;
// --- <<IS-END-IMPORTS>> ---

public final class converter

{
	// ---( internal utility methods )---

	final static converter _instance = new converter();

	static converter _newInstance() { return new converter(); }

	static converter _cast(Object o) { return (converter)o; }

	// ---( server methods )---




	public static final void asTransAmt (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(asTransAmt)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required strValue
		// [i] field:0:required strMultiply
		// [o] object:0:required value
		IDataCursor c = pipeline.getCursor();
		String val = IDataUtil.getString(c, "strValue");
		String mtp = IDataUtil.getString(c, "strMultiply");
		
		BigDecimal bd1 = new BigDecimal(val);
		BigDecimal bd2 = new BigDecimal(mtp);
		String value = bd1.multiply(bd2).setScale(0,BigDecimal.ROUND_DOWN).toString();	
		IDataUtil.put(c, "value", value);
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void dateObjToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateObjToString)>> ---
		// @sigtype java 3.5
		// [i] object:0:required javaDate
		// [i] field:0:required dateTimeFormat
		// [o] field:0:required strDate
		IDataCursor idc = pipeline.getCursor();
		
		Date javaDate = (Date) IDataUtil.get(idc, "javaDate");
		String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
		
		if (javaDate == null){
			//do nothing
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
			String outStr = sdf.format(javaDate);
			IDataUtil.put(idc, "strDate", outStr);			
		}
		
		idc.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void getNull (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getNull)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] object:0:required _null
		IDataCursor c = pipeline.getCursor();
		IDataUtil.put(c, "_null", null);
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void objectToString (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(objectToString)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required inputObj
		// [o] field:0:required outputStr
		IDataCursor idc = pipeline.getCursor();
		
		try {
			Object inputObj = IDataUtil.get(idc, "inputObj");
			IDataUtil.put(idc, "outputStr", String.valueOf(inputObj));
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void objectToStringV2 (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(objectToStringV2)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required inputObj
		// [o] field:0:required outputStr
		IDataCursor idc = pipeline.getCursor();
		
		try {
			Object inputObj = IDataUtil.get(idc, "inputObj");
			if (inputObj == null){
				IDataUtil.put(idc, "outputStr", null);
			} else {
				IDataUtil.put(idc, "outputStr", String.valueOf(inputObj));
			}
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToBigInteger (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToBigInteger)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] object:0:required outBigInteger
		IDataCursor c = pipeline.getCursor();
		String inString = IDataUtil.getString(c, "inString");
		
		if (inString == null || inString.equals("")){
			//do nothing
		} else {
			IDataUtil.put(c, "outBigInteger", new BigInteger(inString));	
		}
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToBoolean (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToBoolean)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] object:0:required outBoolean
		IDataCursor c = pipeline.getCursor();		
		String inString = IDataUtil.getString(c, "inString");
		
		if (inString == null || inString.equals("")){
			//do nothing
		} else {
			String temp = inString.trim().toLowerCase();
			if (temp.equals("true") ){
				IDataUtil.put(c, "outBoolean", new Boolean(true));
			} else if(temp.equals("false")){
				IDataUtil.put(c, "outBoolean", new Boolean(false));
			} else{
				throw new ServiceException("unknow boolean value " + inString);
			}			
		}
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToDate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToDate)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required dateTimeFormat
		// [o] object:0:required outDate
		IDataCursor idc = pipeline.getCursor();
		String strDate = IDataUtil.getString(idc, "inString");
		
		if (strDate == null || strDate.equals("")){
			//do nothing
		} else {
			try {
				String dateTimeFormat = IDataUtil.getString(idc, "dateTimeFormat");
				SimpleDateFormat sdf = new SimpleDateFormat(dateTimeFormat);
				Date outJava = sdf.parse(strDate);
				IDataUtil.put(idc, "outDate", outJava);
			} catch (Exception exc) {
				ServerAPI.logError(exc);
				throw new ServiceException(exc.toString());
			}
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToInteger (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToInteger)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] object:0:required outInteger
		IDataCursor c = pipeline.getCursor();
		String inString = IDataUtil.getString(c, "inString");
		
		if (inString == null || inString.equals("")){
			//do nothing
		} else {
			IDataUtil.put(c, "outInteger", new Integer(inString));	
		}
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToLong (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToLong)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] object:0:required outLong
		IDataCursor c = pipeline.getCursor();
		String inString = IDataUtil.getString(c, "inString");
		
		if (inString == null || inString.equals("")){
			//do nothing
		} else {
			IDataUtil.put(c, "outLong", new Long(inString));			
		}
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToObject (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToObject)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required inputStr
		// [i] field:0:required objectType {"Double","Float","Long","Integer","Byte","Boolean"}
		// [o] object:0:required outputObj
		IDataCursor idc = pipeline.getCursor();
		
		try {
			if (IDataUtil.getString(idc, "inputStr") != null){
				String inputStr = IDataUtil.getString(idc, "inputStr");
				String objectType = IDataUtil.getString(idc, "objectType");
				
				if (objectType.equalsIgnoreCase("Double")){
					Double outVal = new Double(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				} else if (objectType.equalsIgnoreCase("Float")){
					Float outVal = new Float(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				} else if (objectType.equalsIgnoreCase("Long")){
					Long outVal = new Long(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				} else if (objectType.equalsIgnoreCase("Integer")){
					Integer outVal = new Integer(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				} else if (objectType.equalsIgnoreCase("Bytes")){
					Byte outVal = new Byte(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				}else if (objectType.equalsIgnoreCase("String")){
					String outVal = new String(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				} else if (objectType.equalsIgnoreCase("Boolean")){
					Boolean outVal = new Boolean(inputStr);
					IDataUtil.put(idc, "outputObj", outVal);
				}
			}		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void stringToShort (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(stringToShort)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [o] object:0:required outShort
		IDataCursor c = pipeline.getCursor();
		
		String inString = IDataUtil.getString(c, "inString");
		if (inString == null || inString.equals("")){
			//do nothing
		} else {
			IDataUtil.put(c, "outShort", new Short(inString));				
		}
		
		c.destroy();
		// --- <<IS-END>> ---

                
	}
}

