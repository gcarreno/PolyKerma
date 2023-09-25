unit PolyKerma.Modules.Module;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
, PolyKerma.Logging
, PolyKerma.Dispatching
, PolyKerma.Dispatching.Interfaces
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
  Debug({$I %FILE%}, {$I %LINE%}, 'Module Create');
  FDispatcher:= ADispatcher;
  FDispatcher.Register(cChannelModuleIn, Self);
end;

destructor TInterfacedModule.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Module Destroy');
  inherited Destroy;
end;

end.



