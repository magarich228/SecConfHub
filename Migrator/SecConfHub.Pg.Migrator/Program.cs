using SecConfHub.Pg.Migrator;

throw new NotImplementedException();

var connectionString = args.FirstOrDefault() ?? "Host=localhost;Port=5432;Database=SecConfHub;Username=postgres;Password=*";

// var loader = new ExcelToPostgresLoader(connectionString);
var loader = new ExcelToPostgresNPOILoader(connectionString);
loader.ProcessFile("default.xlsx");