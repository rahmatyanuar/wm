package WxPreUpgradeAnalyzer.excel.pub;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.WorkbookUtil;
// --- <<IS-END-IMPORTS>> ---

public final class sheet

{
	// ---( internal utility methods )---

	final static sheet _instance = new sheet();

	static sheet _newInstance() { return new sheet(); }

	static sheet _cast(Object o) { return (sheet)o; }

	// ---( server methods )---




	public static final void sheetAutoFitColumns (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetAutoFitColumns)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required colStart
		// [i] field:0:optional colEnd
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		int	colStart = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colStart" ),0);
		int	colEnd = getIntegerFromString(IDataUtil.getString( pipelineCursor, "colEnd" ), colStart);
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;
		
		for(int i = colStart;i <= colEnd;i++){
			sheet.autoSizeColumn(i);
		}	
		// --- <<IS-END>> ---

                
	}



	public static final void sheetCreate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetCreate)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSWorkbook
		// [i] field:0:required SheetName
		// [o] object:0:required MSSheet
		// pipeline 
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSWorkbook = IDataUtil.get( pipelineCursor, "MSWorkbook" );
		String	SheetName = IDataUtil.getString( pipelineCursor, "SheetName" );
		pipelineCursor.destroy();
		// pipeline
		
		Workbook wb = (Workbook) MSWorkbook; 
		
		String safeName = WorkbookUtil.createSafeSheetName(SheetName); 
		Sheet sheet1 = wb.createSheet(safeName);
		wb.setActiveSheet(wb.getSheetIndex(safeName));
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet1 );
		pipelineCursor_1.destroy();
		// pipeline
		// --- <<IS-END>> ---

                
	}



	public static final void sheetDelete (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetDelete)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSWorkbook
		// [i] object:0:required MSSheet
		// [o] object:0:required MSWorkbook
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSWorkbook = IDataUtil.get( pipelineCursor, "MSWorkbook" );
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		pipelineCursor.destroy();
		// pipeline
		
		Workbook wb = (Workbook)MSWorkbook;
		Sheet sheet = (Sheet)MSSheet;
		wb.removeSheetAt(wb.getSheetIndex(sheet));
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSWorkbook", wb );
		pipelineCursor_1.destroy();
		// pipeline
		// --- <<IS-END>> ---

                
	}



	public static final void sheetGetAndActivateByName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetGetAndActivateByName)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSWorkbook
		// [i] field:0:required sheetName
		// [o] object:0:required MSWorkbook
		// [o] object:0:required MSSheet
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSWorkbook = IDataUtil.get( pipelineCursor, "MSWorkbook" );
		String	sheetName = IDataUtil.getString( pipelineCursor, "sheetName" );
		pipelineCursor.destroy();
		// pipeline
		
		Workbook wb = (Workbook)MSWorkbook;
		Sheet sheet = wb.getSheet(sheetName); 
		wb.setActiveSheet(wb.getSheetIndex(sheetName));
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSWorkbook", wb );
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		pipelineCursor_1.destroy();
		// pipeline	
		// --- <<IS-END>> ---

                
	}



	public static final void sheetProtect (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetProtect)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required Password
		// [o] object:0:required MSSheet
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		String	password = IDataUtil.getString( pipelineCursor, "Password" );
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;
		sheet.protectSheet(password);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.remove(pipelineCursor_1, "Password");
		pipelineCursor_1.destroy();
		// pipeline
		// --- <<IS-END>> ---

                
	}



	public static final void sheetRename (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetRename)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [i] field:0:required newName
		// [o] object:0:required MSSheet
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		String	newName = IDataUtil.getString( pipelineCursor, "newName" );
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet)MSSheet;
		
		int sheetIndex = sheet.getWorkbook().getSheetIndex(sheet);
		sheet.getWorkbook().setSheetName(sheetIndex, newName);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		pipelineCursor_1.destroy();
		// pipeline
		// --- <<IS-END>> ---

                
	}



	public static final void sheetUnProtect (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sheetUnProtect)>> ---
		// @sigtype java 3.5
		// [i] object:0:required MSSheet
		// [o] object:0:required MSSheet
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		Object	MSSheet = IDataUtil.get( pipelineCursor, "MSSheet" );
		String	password = IDataUtil.getString( pipelineCursor, "Password" );
		pipelineCursor.destroy();
		// pipeline
		
		Sheet sheet = (Sheet) MSSheet;
		sheet.protectSheet(null);
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "MSSheet", sheet );
		IDataUtil.remove(pipelineCursor_1, "Password");
		pipelineCursor_1.destroy();
		// pipeline
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
	
	public static int getIntegerFromString(String value, int defaultValue){
		int i = defaultValue;
		
		try {
			i = Integer.parseInt(value);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			
		}
		
		return i;
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

