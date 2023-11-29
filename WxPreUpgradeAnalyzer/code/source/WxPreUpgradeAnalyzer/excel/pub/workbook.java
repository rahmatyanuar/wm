package WxPreUpgradeAnalyzer.excel.pub;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import org.apache.poi.xssf.usermodel.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
// --- <<IS-END-IMPORTS>> ---

public final class workbook

{
	// ---( internal utility methods )---

	final static workbook _instance = new workbook();

	static workbook _newInstance() { return new workbook(); }

	static workbook _cast(Object o) { return (workbook)o; }

	// ---( server methods )---




	public static final void workbookCreate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(workbookCreate)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional Version {"xls","xlsx"}
		// [o] object:0:required MSWorkbook
		// pipeline 
		IDataCursor pipelineCursor1 = pipeline.getCursor();
		String	Version = IDataUtil.getString( pipelineCursor1, "Version" );
		pipelineCursor1.destroy();
		
		Workbook wb = null;
		
		try {
			if(Version == null) Version = "xls"; //Default
			if(Version.equals("xls")){
				wb = new HSSFWorkbook();
			} else {
				wb = new XSSFWorkbook();
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		IDataUtil.put( pipelineCursor, "MSWorkbook", wb );
		pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void workbookOpen (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(workbookOpen)>> ---
		// @sigtype java 3.5
		// [i] field:0:required filePath
		// [o] object:0:required MSWorkbook
		// [o] object:0:required MSSheet
		// pipeline 
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	filePath = IDataUtil.getString( pipelineCursor, "filePath" );
		pipelineCursor.destroy();
		
		Workbook wb = null;
		Sheet sheet = null;
		
		//Analyse, ob xls oder xlsx und \u00F6ffnen des ersten Sheets
		try {
			//Versuch als xls zu \u00F6ffnen
			wb = new HSSFWorkbook(new FileInputStream(filePath));
			sheet = wb.getSheetAt(0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			//Versuch als xlsx zu \u00F6ffnen
			try {
				wb = new XSSFWorkbook(new FileInputStream(filePath));
				sheet = wb.getSheetAt(0);
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
		// pipeline
		IDataCursor pipelineCursor_1;
		pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSWorkbook", wb );
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void workbookSave (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(workbookSave)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSWorkbook
		// [i] field:0:required filePath
		// [o] object:0:required MSWorkbook
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSWorkbook = IDataUtil.get( pipelineCursor, "MSWorkbook" );
		String	filePath = IDataUtil.getString( pipelineCursor, "filePath" );
		pipelineCursor.destroy();
		
		Workbook wb = (Workbook) MSWorkbook;
		FileOutputStream fileOut;
		
		if(filePath.endsWith(".xls") && wb instanceof XSSFWorkbook) filePath += "x";
		
		try {
			fileOut = new FileOutputStream(filePath);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSWorkbook", wb );
		pipelineCursor_1.destroy();
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	public static String getCellValueAsString (Cell cell)
	{
		String value = "";
		
		switch (cell.getCellType()) {
	        case Cell.CELL_TYPE_STRING:
	        	value = cell.getRichStringCellValue().getString();
	            break;
	        case Cell.CELL_TYPE_NUMERIC:
	            if (DateUtil.isCellDateFormatted(cell)) {
	                //System.out.println(cell.getDateCellValue());
	                value = cell.getDateCellValue().toString();
	            } else {
	                value = Double.toString(cell.getNumericCellValue());
	            }
	            break;
	        case Cell.CELL_TYPE_BOOLEAN:
	        	value = Boolean.toString(cell.getBooleanCellValue());
	            break;
	        case Cell.CELL_TYPE_FORMULA:
	        	value = cell.getCellFormula();
	            break;
	        default:
	        	value = "";
		}
		
		return value;
	}
	
	public static org.apache.poi.ss.usermodel.Row getValidRow(Sheet mSheet, int mRow){
		Row mZeile;		
		
		//System.out.println("req:"+mRow+" last:"+mSheet.getLastRowNum());
		
		if( mRow <= mSheet.getLastRowNum() )
		{
			mZeile = mSheet.getRow(mRow);
		}
		else	
		{
			mZeile = mSheet.createRow(mRow);	
		}
	
		return mZeile;
	}
	// --- <<IS-END-SHARED>> ---
}

