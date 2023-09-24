unit PolyKerma.Modules.Module;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Dispatcher.Interfaces
, PolyKerma.Modules.Interfaces
;

type
{ TInterfacedModule }
  TInterfacedModule = class(TInterfacedObject, IModule)
  private
    FDispatcher: IDispatcher;
  protected
  public
    constructor Create(const ADispatcher: IDispatcher);
    destructor Destroy; override;

  published
  end;
  TInterfacedModuleClass = class of TInterfacedModule;

implementation

{ TDispatcher }

constructor TInterfacedModule.Create(const ADispatcher: IDispatcher);
begin
  FDispatcher:= ADispatcher;
end;

destructor TInterfacedModule.Destroy;
begin
  FDispatcher:= nil;
  inherited Destroy;
end;

end.



