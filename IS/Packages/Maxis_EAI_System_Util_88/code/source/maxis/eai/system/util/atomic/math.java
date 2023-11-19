package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.util.Debug;
import java.util.*;
import java.text.*;
import java.io.*;
import java.lang.System;
import com.wm.util.*;
import com.wm.app.b2b.server.*;
import java.math.*;
// --- <<IS-END-IMPORTS>> ---

public final class math

{
	// ---( internal utility methods )---

	final static math _instance = new math();

	static math _newInstance() { return new math(); }

	static math _cast(Object o) { return (math)o; }

	// ---( server methods )---




	public static final void divideDecimals (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(divideDecimals)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required num1
		// [i] field:0:required num2
		// [i] field:0:required scale
		// [i] field:0:optional roundingMode {"ROUND_CEILING","ROUND_DOWN","ROUND_FLOOR","ROUND_HALF_DOWN","ROUND_HALF_EVEN","ROUND_HALF_UP","ROUND_UNNECESSARY","ROUND_UP"}
		// [o] field:0:required value
		IDataCursor pipelineCursor = pipeline.getCursor();
		java.lang.String num1 = IDataUtil.getString(pipelineCursor, "num1");
		java.lang.String num2 = IDataUtil.getString(pipelineCursor, "num2");
		int scale = IDataUtil.getInt(pipelineCursor, "scale", 0);
		java.lang.String roundmode = IDataUtil.getString(pipelineCursor, "roundingMode");
		int rmode = java.math.BigDecimal.ROUND_HALF_UP;
		if(roundmode != null)
		{
			if("ROUND_CEILING".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_CEILING; }
			else if("ROUND_DOWN".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_DOWN; }
			else if("ROUND_FLOOR".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_FLOOR; }
			else if("ROUND_HALF_DOWN".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_HALF_DOWN; }
			else if("ROUND_HALF_EVEN".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_HALF_EVEN; }
			else if("ROUND_HALF_UP".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_HALF_UP; }
			else if("ROUND_UNNECESSARY".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_UNNECESSARY; }
			else if("ROUND_UP".equals(roundmode))
			{	rmode = java.math.BigDecimal.ROUND_UP; }
		}
		java.math.BigDecimal n1 = new java.math.BigDecimal(num1);
		java.math.BigDecimal n2 = new java.math.BigDecimal(num2);
		java.math.BigDecimal computedValue = n1.divide(n2, scale, rmode);
		
		IDataUtil.put(pipelineCursor, "value", computedValue.toString());
		pipelineCursor.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void mod (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(mod)>> ---
		// @sigtype java 3.5
		// [i] field:0:required num1
		// [i] field:0:required num2
		// [o] field:0:required result
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	num1 = IDataUtil.getString( pipelineCursor, "num1" );
		String	num2 = IDataUtil.getString( pipelineCursor, "num2" );
		
		int int1 = Integer.parseInt(num1);
		int int2 = Integer.parseInt(num2);
		int int3 = int1 % int2;
		
		IDataUtil.put( pipelineCursor, "result", Integer.toString(int3));
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

