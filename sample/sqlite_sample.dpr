program sqlite_sample;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  SQLiteTable3 in '..\SQLiteTable3.pas',
  SQLite3 in '..\SQLite3.pas';

var
  db: TSQLiteDatabase;
  table: TSQLiteTable;

begin
  try
    db := TSQLiteDatabase.Create('test.db');
    try
      db.ExecSQL('INSERT INTO test (name,val,timestamp) VALUES ("‚³‚µ‚·‚¹‚»",777,"1234");');
      table := db.GetTable('SELECT name,val FROM test');
      try
        while True do
        begin
          if table.EOF then
            Break;
          WriteLn(Format('name: %s, val: %d', [table.FieldAsString(table.FieldIndex['name']), table.FieldAsInteger(table.FieldIndex['val'])]));
          table.Next;
        end;
      finally
        FreeAndNil(table);
      end;
    finally
      FreeAndNil(db);
    end;
  except
    on E: Exception do
      WriteLn('error: ', E.Message);
  end;
end.
