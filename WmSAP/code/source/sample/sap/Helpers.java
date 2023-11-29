/*
 * Helpers.java
 *
 * Copyright 2003 webMethods, Inc.
 * ALL RIGHTS RESERVED
 *
 * UNPUBLISHED -- Rights reserved under the copyright laws of the United States.
 * Use of a copyright notice is precautionary only and does not imply
 * publication or disclosure.
 *
 * THIS SOURCE CODE IS THE CONFIDENTIAL AND PROPRIETARY INFORMATION OF
 * WEBMETHODS, INC.  ANY REPRODUCTION, MODIFICATION, DISTRIBUTION,
 * OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY PROHIBITED
 * WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF WEBMETHODS, INC.
 */
package sample.sap;

// --- <<B2B-START-IMPORTS>> ---
import java.io.File;
import java.io.FileWriter;
import java.text.MessageFormat;

import com.sap.conn.jco.AbapException;
import com.wm.adapter.sap.SAPAdapter;
import com.wm.adapter.sap.resources.WmSAPResourceBundle;
import com.wm.adapter.sap.bapi.BAPICoder;
import com.wm.adapter.sap.rfc.RFCCoder;
import com.wm.adapter.sap.service.transport.BAPI;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;
import com.wm.data.IDataUtil;
import com.wm.util.Values;
// --- <<B2B-END-IMPORTS>> ---

public final class Helpers
{
	// ---( internal utility methods )---
	final static Helpers _instance = new Helpers();
	static Helpers _newInstance() { return new Helpers(); }
	static Helpers _cast( Object o) { return (Helpers) o; }
	// ---( server methods )---

	// --- <<B2B-START-SHARED>> ---
	public static final String RFC_XRFC			= "XRFC";
	public static final String RFC_BXML			= "bXML";

	public static final String BAPI_SYNC		= "sync";
	public static final String BAPI_ASYNC		= "async";
	public static final String BAPI_ROUTE		= "routing";

	private static final byte SYNC_MODE			= 0;
	private static final byte ASYNC_MODE		= 1;
	private static final byte ROUTING_MODE		= 2;

	private static final String _memberPattern	=
		"\n          <member>"
		+"\n            <name>{0}</name>"
		+"\n            <value>"
		+"\n              <string>{1}</string>"
		+"\n            </value>"
		+"\n          </member>";

	private static final boolean write2File( IData pipeline, String fileName, String extension)
		throws java.io.IOException
	{
		IDataCursor idc = pipeline.getCursor();
		String xmlData = IDataUtil.getString( idc, "xmlData");
		idc.destroy();

		String filePath = "packages" + File.separator + Service.getPackageName() +
		File.separator + "pub" + File.separator + fileName + extension;
		FileWriter fout = new FileWriter( new File( filePath));
		fout.write( xmlData);
		fout.close();
		return true;
	}
	// --- <<B2B-END-SHARED>> ---

	/**
	 * This service will convert RFCs or IDocs coming from an SAP ECC system to SAP-XML
	 * (IDoc-XML or RFC-XML) and write the result to an output file in the 'WmSAP/pub'
	 * directory.
	 *
	 * To call it create a routing rule, choose the B2B transport and specify this
	 * service or call it directly.
	 *
	 * @param	pipeline The pipeline
	 * @throws	ServiceException If there is an error during execution of this service
	 */
	public static final void writeSapXmlFile( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(writeSapXmlFile)>> ---
		// @sigtype java 3.5
		IDataCursor idc = pipeline.getCursor();

		try
		{
			// If you want to know what keys are passed in with the pipeline
			// uncomment the next lines
			//	String[] keys = in.getValueKeys();
			//	for (int i=0; i<keys.length; i++)
			//		System.out.println(keys[i] + " = " + in.get(keys[i]));

			String fileName = "writeSAPXMLFile";
			String fNextension = ".xml";

			// Check whether we got XML right away
			if( IDataUtil.contains( idc, "xmlData"))
			{
				System.out.println( "Got XML input, nothing left to do ;-)");
				if( IDataUtil.contains( idc, "$tid"))
					fileName = IDataUtil.getString( idc, "$tid");
				else if( IDataUtil.contains( idc, "$rfcname"))
					fileName = IDataUtil.getString( idc, "$rfcname");
			}
			// Check for calls coming from the SAP system direct or via IS transport
			else if( IDataUtil.contains( idc, "iDocList") || IDataUtil.contains( idc, "IDOC_DATA") || IDataUtil.contains( idc, "IDOC_DATA_REC_40"))
			{
				System.out.println( "It's an IDOC coming from SAP ECC or via IS transport!");
				Service.doInvoke( "pub.sap.idoc", "encode", pipeline);
				fileName = IDataUtil.getString( idc, "$tid");

				// Clean up pipeline
				IDataUtil.remove( idc, "IDOC_DATA");
				IDataUtil.remove( idc, "IDOC_DATA_REC_40");
				IDataUtil.remove( idc, "IDOC_CONTROL");
				IDataUtil.remove( idc, "IDOC_CONTROL_REC_40");
			}
			else if( IDataUtil.contains( idc, "$rfcname"))
			{
				System.out.println( "It's an RFC coming from SAP ECC or via IS transport!");
				Service.doInvoke( "pub.sap.rfc", "encode", pipeline);
				if( IDataUtil.contains( idc, "$tid"))
					fileName = IDataUtil.getString( idc, "$tid");
				else if( IDataUtil.contains( idc, "$rfcname"))
					fileName = IDataUtil.getString( idc, "$rfcname");
			}
			else
				System.out.println( "Unknown content type, input needs to come from SAP System via RFC or IDoc.");

			// Persists the XML document
			write2File( pipeline, fileName, fNextension);
		}
		catch( Exception e)
		{
			System.out.println( e.toString());
		}

		// --- <<B2B-END>> ---
	}


	/**
	 * <code>sample.sap:invokeAndReturnXml</code>
	 *
	 * @param pipeline The pipeline
	 * @throws ServiceException If there is an error during execution of this service
	 */
	public static final void invokeAndReturnXml( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(invokeAndReturnXml)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serverName
		// [i] field:0:required $rfcname
		// [i] field:0:optional $envelope {"XRFC","bXML"}
		// [i] field:0:optional $tid
		// [o] field:0:required xmlData
		IDataCursor idc = pipeline.getCursor();

		// Get values from the pipeline
		String serverName	= IDataUtil.getString( idc, "serverName");
		String rfcName		= IDataUtil.getString( idc, "$rfcname");
		String tid			= IDataUtil.getString( idc, "$tid");
		String envelope		= IDataUtil.getString( idc, "$envelope");

		// Invoke the RFC
		try
		{
			if( tid != null && tid.length() > 0)
				Service.doInvoke( "pub.sap.client", "invokeTransaction", Service.getSession(), pipeline);
			else
				Service.doInvoke( "pub.sap.client", "invoke", Service.getSession(), pipeline);
		}
		catch (Exception e)
		{
			IDataUtil.copy( new ServiceException( e).getErrorDetails(), pipeline);
		}

		IDataUtil.put( idc, "$call"		, "false");
		IDataUtil.put( idc, "serverName", serverName);
		IDataUtil.put( idc, "$rfcname"	, rfcName);
		boolean bXML = (envelope != null && envelope.equals( "bXML"));
		RFCCoder coder = new RFCCoder( bXML);
		try
		{
			byte[] result = coder.encodeToBytes( Values.use( pipeline));
			IDataUtil.remove( idc, "$error");
			IDataUtil.remove( idc, "$errorType");
			if (coder.getIsoEncoding() != null) // If an encoding was recognized, use it and put it
												// in the pipeline
			{
				IDataUtil.put( idc, "xmlData", new String( result, coder.getIsoEncoding()));
				IDataUtil.put( idc, "$encoding", coder.getEncoding());
			}
			else
				IDataUtil.put( idc, "xmlData", new String( result, "UTF8"));
		}
		catch (Exception e)
		{
			throw new ServiceException( e);
		}
		// --- <<B2B-END>> ---
	}


	/**
	 * <code>sample.sap:invokeBapiReturningBXml</code>
	 *
	 * @param	pipeline The pipeline
	 * @throws	ServiceException If there is an error during execution of this service
	 */
	public static final void invokeBapiReturningBXml( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(invokeBapiReturningBXml)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serverName
		// [i] field:0:optional mode {"sync", "async, "routing"}
		// [o] field:0:required xmlData
		IDataCursor idc = pipeline.getCursor();
		byte mode = SYNC_MODE;

		// Get selected mode, if none is specified, set to sync --> RFC call
		if( idc.first( "mode"))
		{
			String modeStr = IDataUtil.getString( idc);
			if( modeStr != null)
			{
				if( modeStr.equals( BAPI_SYNC))
					mode = SYNC_MODE;
				else if( modeStr.equals( BAPI_ASYNC))
					mode = ASYNC_MODE;
				else if( modeStr.equals( BAPI_ROUTE))
					mode = ROUTING_MODE;
			}
		}
		String serverName = IDataUtil.getString( idc, "serverName");
		if( serverName == null && mode != ROUTING_MODE)
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_ARGUMENT_MISSING, "\"serverName\"");
			throw new ServiceException( exMsg);
		}
		try
		{
			BAPICoder coder = new BAPICoder();
			IData request = IDataFactory.create();
			IDataUtil.copy( pipeline, request);
			IDataCursor requestCursor = request.getCursor();
			IDataUtil.put( requestCursor, "$call", "true");
			byte[] data = null;
			IData response = null;
			Values transParams = new Values( 2);
			transParams.put( "server", serverName);
			try
			{
				switch( mode)
				{
					case ASYNC_MODE:
						transParams.put( "mode", BAPI.ASYNC_MODE);
						// If async is wished, always provide a TID
						if( !IDataUtil.contains( requestCursor, "$tid"))
						{
							Object[][] o = {
								{
										"serverName", serverName
								}
							};
							IData tmp = Service.doInvoke( "pub.sap.client", "createTID", IDataFactory.create( o));
							String tid = IDataUtil.getString( tmp.getCursor(), "$tid");
							IDataUtil.put( requestCursor, "$tid", tid);
						}
						IDataUtil.put( requestCursor, "transportParams", transParams);
						response = Service.doInvoke( "pub.sap.transport.BAPI", "OutboundProcess", request);
						break;
					case SYNC_MODE:
						transParams.put( "mode", BAPI.SYNC_MODE);
						IDataUtil.remove( requestCursor, "$tid"); // Ensure there's no transaction assigned to sync call
						IDataUtil.put( requestCursor, "transportParams", transParams);
						response = Service.doInvoke( "pub.sap.transport.BAPI", "OutboundProcess", request);
						break;
					case ROUTING_MODE:
						response = Service.doInvoke( "pub.sap.transport.BAPI", "InboundProcess", request);
						break;
				}
				data = coder.encodeToBytes( Values.use( response));
			}
			catch( Exception e)
			{
				IDataUtil.copy( new ServiceException( e).getErrorDetails(), request);
				data = coder.encodeToBytes( Values.use( request));
			}

			String xmlOut;
			if( coder.getIsoEncoding() != null) // If an encoding was recognized, use it and put it in the pipeline!
			{
				xmlOut = new String( data, coder.getIsoEncoding());
				IDataUtil.put( idc, "$encoding", coder.getEncoding());
			}
			else
				xmlOut = new String( data, "UTF8");
			idc.insertAfter( "xmlData", xmlOut);
		}
		catch( Exception e)
		{
			throw new ServiceException( e);
		}
		idc.destroy();
		// --- <<B2B-END>> ---
	}

	/**
	 * Encodes a simple structure into an RPC-XML response.
	 *
	 * @param	pipeline The pipeline
	 * @throws	ServiceException If there is an error during execution of this service
	 */
	public static final void encodeRPCResponse( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(encodeRPCResponse)>> ---
		// @sigtype java 3.5
		// [i] record:0:required document
		// [o] field:0:required xmlData
		IDataCursor idc = pipeline.getCursor();
		IData doc = IDataUtil.getIData( idc, "document");
		IDataCursor docC = null;
		if (doc != null)
			docC = doc.getCursor();
		else
		{
			String exMsg = SAPAdapter.getMessage( WmSAPResourceBundle.WMSAP_ARGUMENT_MISSING, "\"document\"");
			throw new ServiceException( exMsg);
		}

		StringBuffer buf = new StringBuffer(
				"<?xml version=\"1.0\"?>"
				+"\n<methodResponse>"
				+"\n  <params>"
				+"\n    <param>"
				+"\n      <value>"
				+"\n        <struct>");
		while ( docC.next())
		{
			String member = MessageFormat.format( _memberPattern, new Object[] { docC.getKey(), docC.getValue() });
			buf = buf.append( member);
		}
		buf = buf.append(
				"\n        </struct>"
				+"\n      </value>"
				+"\n    </param>"
				+"\n  </params>"
				+"\n</methodResponse>");
		IDataUtil.put( idc, "xmlData", buf.toString());
		docC.destroy();
		idc.destroy();
		// --- <<B2B-END>> ---
	}

	/**
	 * <code>sample.sap:throwAbapException</code>
	 *
	 * @param	pipeline The pipeline
	 * @throws	ServiceException If there is an error during execution of this service
	 */
	public static final void returnABAPException( IData pipeline) throws ServiceException, AbapException
	{
		// --- <<B2B-START(returnABAPException)>> ---
		// @sigtype java 3.5
		// [i] field:0:required key
		// [i] field:0:optional message

		// Get values from the pipeline
		IDataCursor idc = pipeline.getCursor();
		String key = IDataUtil.getString( idc, "key");
		String message = IDataUtil.getString( idc, "message");
		idc.destroy();

		// Check input
		if( key == null)
			throw new ServiceException( "Missing required input parameter \"key\"");

		// Throw the ABAP exception
		if( message != null)
			throw new AbapException( key, message);
		else
			throw new AbapException( key);

		// --- <<B2B-END>> ---
	}
}