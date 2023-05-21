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
, PolyKerma.Dispatcher.Objects
;

type

  TTestDispatcher= class(TTestCase)
  private
    FDispatcher: IDispatcher;
  protected
  public
  published
    procedure TestDispatherCreate;
  end;

implementation

procedure TTestDispatcher.TestDispatherCreate;
begin
  FDispatcher:= TDispatcher.Create;
  AssertNotNull('Dispatcher not null', FDispatcher);
end;



initialization

  RegisterTest(TTestDispatcher);
end.

