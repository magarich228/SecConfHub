using System.Data;
using Npgsql;
using OfficeOpenXml;

namespace SecConfHub.Pg.Migrator;

class ExcelToPostgresLoader(string connectionString)
{
    public void ProcessFile(string filePath)
    {
        using var package = new ExcelPackage(new FileInfo(filePath));
        foreach (var worksheet in package.Workbook.Worksheets)
        {
            string tableName = worksheet.Name;
            Console.WriteLine($"Processing sheet: {tableName}");

            DataTable dt = ReadExcelSheet(worksheet);

            BulkInsert(tableName, dt);
        }
    }

    private DataTable ReadExcelSheet(ExcelWorksheet worksheet)
    {
        DataTable dt = new DataTable();

        foreach (var firstRowCell in worksheet.Cells[1, 1, 1, worksheet.Dimension.End.Column])
        {
            dt.Columns.Add(firstRowCell.Text);
        }

        for (int rowNum = 2; rowNum <= worksheet.Dimension.End.Row; rowNum++)
        {
            var wsRow = worksheet.Cells[rowNum, 1, rowNum, worksheet.Dimension.End.Column];
            DataRow row = dt.Rows.Add();
            
            foreach (var cell in wsRow)
            {
                row[cell.Start.Column - 1] = cell.Text;
            }
        }

        return dt;
    }

    private void BulkInsert(string tableName, DataTable data)
    {
        using var conn = new NpgsqlConnection(connectionString);
        conn.Open();

        using var writer = conn.BeginBinaryImport($"COPY {tableName} FROM STDIN (FORMAT BINARY)");
        
        foreach (DataRow row in data.Rows)
        {
            writer.StartRow();
                    
            foreach (var item in row.ItemArray)
            {
                writer.Write(item.ToString());
            }
        }
                
        writer.Complete();
    }
}