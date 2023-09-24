program PolyKermaTests;

{$mode objfpc}{$H+}

uses
  Classes
, consoletestrunner
, PolyKerma.Test.Dispatcher
;

type

{ TPolyKermaTestRunner }
  TPolyKermaTestRunner = class(TTestRunner)
  protected
  // override the protected methods of TTestRunner to customize its behavior
  end;

var
  Application: TPolyKermaTestRunner;

begin
  Application := TPolyKermaTestRunner.Create(nil);
  Application.Initialize;
  Application.Title := 'PolyKerma Console test runner';
  Application.Run;
  Application.Free;
end.
