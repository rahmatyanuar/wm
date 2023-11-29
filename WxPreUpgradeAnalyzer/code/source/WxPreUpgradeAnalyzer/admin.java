package WxPreUpgradeAnalyzer;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class admin

{
	// ---( internal utility methods )---

	final static admin _instance = new admin();

	static admin _newInstance() { return new admin(); }

	static admin _cast(Object o) { return (admin)o; }

	// ---( server methods )---




	public static final void init (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(init)>> ---
		// @sigtype java 3.5
		IData in = IDataFactory.create();
		ValuesEmulator.put(in, "callback", "WxPreUpgradeAnalyzer.admin:setParm");
		  try {
		     Service.doInvoke("wm.server.ui", "addSolution", in);
		  } catch (Exception var3) {
			//  throw new ServiceException(var3);
		  }			
		// --- <<IS-END>> ---

                
	}



	public static final void setParm (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(setParm)>> ---
		// @sigtype java 3.5
		ValuesEmulator.put(pipeline, "name", "Pre-Upgrade Analyzer");
		ValuesEmulator.put(pipeline, "url", "../WxPreUpgradeAnalyzer/index.dsp");
		ValuesEmulator.put(pipeline, "target", "PUA");
		ValuesEmulator.put(pipeline, "text", "Pre-Upgrade Analyzer");
			
		// --- <<IS-END>> ---

                
	}



	public static final void shutDown (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(shutDown)>> ---
		// @sigtype java 3.5
		IData in = IDataFactory.create();
		  ValuesEmulator.put(in, "callback", "WxPreUpgradeAnalyzer.admin:setParm");
		
		  try {
		     Service.doInvoke("wm.server.ui", "removeSolution", in);
		  } catch (Exception var3) {
			  throw new ServiceException(var3);
		  }
			
		// --- <<IS-END>> ---

                
	}
}

