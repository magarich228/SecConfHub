using SecConfHub.Pg.Migrator;

throw new NotImplementedException();

#pragma warning disable CS0162 // Unreachable code detected
var connectionString = args.FirstOrDefault() ?? "Host=localhost;Port=5432;Database=SecConfHub;Username=postgres;Password=*";

// var loader = new ExcelToPostgresLoader(connectionString);
var loader = new ExcelToPostgresNPOILoader(connectionString);
loader.ProcessFile("default.xlsx");
#pragma warning restore CS0162 // Unreachable code detected
