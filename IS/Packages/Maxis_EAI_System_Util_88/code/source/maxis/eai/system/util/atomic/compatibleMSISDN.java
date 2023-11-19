package maxis.eai.system.util.atomic;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-10-10 23:20:23 MYT
// -----( ON-HOST: maxis71

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
// --- <<IS-END-IMPORTS>> ---

public final class compatibleMSISDN

{
	// ---( internal utility methods )---

	final static compatibleMSISDN _instance = new compatibleMSISDN();

	static compatibleMSISDN _newInstance() { return new compatibleMSISDN(); }

	static compatibleMSISDN _cast(Object o) { return (compatibleMSISDN)o; }

	// ---( server methods )---




	public static final void makeCompatibleMSISDN (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(makeCompatibleMSISDN)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required origMSISDN
		// [i] field:0:required compatibleFormat {"leadingPlus","countryCode_NoLeadingPlus","noCountryCode_NoLeadingZero","noCountryCode_LeadingZero"}
		// [o] field:0:required compatibleMSISDN
		IDataCursor idc = pipeline.getCursor();
		
		try {
			String origMSISDN = IDataUtil.getString(idc, "origMSISDN");
			String compatibleFormat = IDataUtil.getString(idc, "compatibleFormat");
		
			if ((origMSISDN == null) || (compatibleFormat == null)) return;
		
			origMSISDN = origMSISDN.trim();
			compatibleFormat = compatibleFormat.trim();
			String compatibleMSISDN = null;
		
			if (compatibleFormat.equalsIgnoreCase("leadingPlus")) { // e.g. +62811012345
				if (!origMSISDN.startsWith("+")) {
					if (origMSISDN.startsWith("0")) origMSISDN = origMSISDN.substring(1);
					if (!origMSISDN.startsWith(COUNTRY_CODE)) origMSISDN = COUNTRY_CODE + origMSISDN;
					origMSISDN = "+" + origMSISDN;
				}
			}
		
			if (compatibleFormat.equalsIgnoreCase("countryCode_NoLeadingPlus")) { // e.g. 62811012345
				if (origMSISDN.startsWith("0")) origMSISDN = origMSISDN.substring(1);
				if (origMSISDN.startsWith("+")) origMSISDN = origMSISDN.substring(1);
				if (!origMSISDN.startsWith(COUNTRY_CODE)) origMSISDN = COUNTRY_CODE + origMSISDN;
			}
				
			if (compatibleFormat.equalsIgnoreCase("noCountryCode_NoLeadingZero")) { // e.g. 811012345
				if (origMSISDN.startsWith("0")) origMSISDN = origMSISDN.substring(1);
				if (origMSISDN.startsWith("+")) origMSISDN = origMSISDN.substring(1);
				if (origMSISDN.startsWith(COUNTRY_CODE)) origMSISDN = origMSISDN.substring(2);
			}
		
			if (compatibleFormat.equalsIgnoreCase("noCountryCode_LeadingZero")) { // e.g. 0811012345
				if (origMSISDN.startsWith("+")) origMSISDN = origMSISDN.substring(1);
				if (origMSISDN.startsWith(COUNTRY_CODE)) origMSISDN = origMSISDN.substring(2);
				if (!origMSISDN.startsWith("0")) origMSISDN = "0" + origMSISDN;
			}
			
			compatibleMSISDN = origMSISDN;
			IDataUtil.put(idc, "compatibleMSISDN", compatibleMSISDN);
		
		} catch (Exception exc) {
			ServerAPI.logError(exc);
			throw new ServiceException(exc.toString());
		}
		
		idc.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static final String COUNTRY_CODE = "60";
	// --- <<IS-END-SHARED>> ---
}

