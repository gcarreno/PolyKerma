unit PolyKerma.Modules.Module;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Modules.Interfaces
;

type
{ TModule }
  TModule = class(TInterfacedObject, IModule)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TDispatcher }

constructor TModule.Create;
begin

end;

destructor TModule.Destroy;
begin
  inherited Destroy;
end;

end.



