program PolyKermaTests;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  cmem,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Classes
, consoletestrunner
, PolyKerma.Test.Dispatcher
, PolyKerma.Test.Messages
, PolyKerma.Test.Module
, PolyKerma.Test.Threads
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
