unit PolyKerma.Test.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, fpcunit
//, testutils
, testregistry
, PolyKerma.Dispatcher.Interfaces
, PolyKerma.Dispatcher
;

type

  TTestDispatcher= class(TTestCase)
  private
    FDispatcher: IDispatcher;
  protected
  public
  published
    procedure TestDispatcherCreate;
  end;

implementation

procedure TTestDispatcher.TestDispatcherCreate;
begin
  FDispatcher:= TDispatcher.Create;
  AssertNotNull('Dispatcher not null', FDispatcher);
end;



initialization

  RegisterTest(TTestDispatcher);
end.

