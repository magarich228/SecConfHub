using System.Data;
using System.Globalization;
using Npgsql;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace SecConfHub.Pg.Migrator;

class ExcelToPostgresNPOILoader(string connectionString)
{
    public void ProcessFile(string filePath)
    {
        using var stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
        var workbook = new XSSFWorkbook(stream);
            
        foreach (ISheet sheet in workbook)
        {
            string tableName = sheet.SheetName;
            Console.WriteLine($"Processing sheet: {tableName}");

            DataTable dt = ReadExcelSheet(sheet);
            BulkInsert(tableName, dt);
        }
    }

    private DataTable ReadExcelSheet(ISheet sheet)
    {
        DataTable dt = new DataTable();
        IRow headerRow = sheet.GetRow(0);

        foreach (ICell cell in headerRow)
        {
            dt.Columns.Add(cell.ToString());
        }

        for (int rowNum = 1; rowNum <= sheet.LastRowNum; rowNum++)
        {
            IRow row = sheet.GetRow(rowNum);
            if (row == null) continue;

            DataRow dataRow = dt.NewRow();
            for (int i = 0; i < headerRow.LastCellNum; i++)
            {
                ICell cell = row.GetCell(i);
                dataRow[i] = cell?.ToString() ?? DBNull.Value.ToString(CultureInfo.InvariantCulture);
            }
            dt.Rows.Add(dataRow);
        }

        return dt;
    }

    private void BulkInsert(string tableName, DataTable data)
    {
        using var conn = new NpgsqlConnection(connectionString);
        conn.Open();

        using var writer = conn.BeginBinaryImport($"COPY {tableName} FROM STDIN (FORMAT BINARY)");
        
        for (int i = 1; i <= data.Rows.Count; i++)
        {
            writer.StartRow();
            
            foreach (var item in data.Rows[i].ItemArray)
            {
                writer.Write(item?.ToString());
            }
        }
                
        writer.Complete();
    }
}