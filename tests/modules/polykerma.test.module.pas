unit PolyKerma.Test.Module;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, fpcunit
//, testutils
, testregistry
, PolyKerma.Modules.Interfaces
, PolyKerma.Modules.Module
;

type

  TTestModule= class(TTestCase)
  private
    FModule: IModule;
  protected
  public
  published
    procedure TestModuleCreate;
  end;

implementation

procedure TTestModule.TestModuleCreate;
begin
  FModule:= TModule.Create;
  AssertNotNull('Module not null', FModule);
end;



initialization

  RegisterTest(TTestModule);
end.

