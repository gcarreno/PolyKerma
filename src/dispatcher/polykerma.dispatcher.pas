unit PolyKerma.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
//, contnrs
, PolyKerma.Logger
, PolyKerma.Dispatcher.Interfaces
//, PolyKerma.Dispatcher.Common
, PolyKerma.Messages.Interfaces
, PolyKerma.Modules.Interfaces
;

type
{ TInterfacedDispatcher }
  TInterfacedDispatcher = class(TInterfacedObject, IDispatcher)
  private
    FMessageList: IInterfaceList;
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
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Dispatcher Create');
  FMessageList:= TInterfaceList.Create;
end;

destructor TInterfacedDispatcher.Destroy;
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Dispatcher Destroy');
  inherited Destroy;
end;

function TInterfacedDispatcher.Register(const AChannel: String;
  const AModule: IModule): Boolean;
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Dispatcher Register');
  Result:= false;
end;

procedure TInterfacedDispatcher.Post(const AMessage: IMessage);
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, Format('Dispatcher Post: %s', [
    AMessage.Channel
  ]));
  FMessageList.Add(AMessage);
end;

end.

