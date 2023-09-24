unit PolyKerma.Test.Threads;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, fpcunit
//, testutils
, testregistry
, PolyKerma.Threads.Interfaces
, PolyKerma.Threads.Thread
;

type

  TTestThreads= class(TTestCase)
  private
    FThread: IThread;
  protected
  public
  published
    procedure TestThreadCreate;
  end;

implementation

procedure TTestThreads.TestThreadCreate;
begin
  FThread:= TInterfacedThread.Create(True);
  AssertNotNull('Thread not null', FThread);
end;



initialization

  RegisterTest(TTestThreads);
end.

