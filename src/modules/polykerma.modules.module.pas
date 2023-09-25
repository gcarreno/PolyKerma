unit PolyKerma.Modules.Module;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Logger
, PolyKerma.Dispatcher.Common
, PolyKerma.Dispatcher.Interfaces
//, PolyKerma.Messages.Interfaces
, PolyKerma.Messages.Message
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
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Module Create');
  FDispatcher:= ADispatcher;
  FDispatcher.Register(cDispatcherChannelModuleIn, Self);
  { #todo -ogcarreno -cexample : Remove after testing }
  FDispatcher.Post(TInterfacedMessage.Create(cDispatcherChannelModelOut));
end;

destructor TInterfacedModule.Destroy;
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Module Destroy');
  inherited Destroy;
end;

end.



