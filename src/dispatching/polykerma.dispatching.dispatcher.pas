unit PolyKerma.Dispatching.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
, System.SysUtils
{$ELSE FPC_DOTTEDUNITS}
  Classes
, SysUtils
{$ENDIF FPC_DOTTEDUNITS}
//, contnrs
, PolyKerma.Logging
, PolyKerma.Dispatching.Interfaces
//, PolyKerma.Dispatching
, PolyKerma.Modules.Interfaces
;

type
{ TInterfacedDispatcher }
  TInterfacedDispatcher = class(TInterfacedObject, IDispatcher)
  private
    FMessageList: IInterfaceList;

    procedure ProcessMessage(const AMessage: IMessage);
  protected
  public
    constructor Create;
    destructor Destroy; override;

    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Post(const AMessage: IMessage);
  published
  end;
  TInterfacedDispatcherClass = class of TInterfacedDispatcher;

implementation

{ TInterfacedDispatcher }

constructor TInterfacedDispatcher.Create;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Create');
  FMessageList:= TInterfaceList.Create;
end;

destructor TInterfacedDispatcher.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Destroy');
  inherited Destroy;
end;

procedure TInterfacedDispatcher.ProcessMessage(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Process Message: %s', [
    AMessage.Channel
  ]));
  //
end;

function TInterfacedDispatcher.Register(const AChannel: String;
  const AModule: IModule): Boolean;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Dispatcher Register');
  Result:= false;
end;

procedure TInterfacedDispatcher.Post(const AMessage: IMessage);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Post: %s', [
    AMessage.Channel
  ]));
  FMessageList.Add(AMessage);
end;

end.

