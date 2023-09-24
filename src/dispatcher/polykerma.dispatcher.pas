unit PolyKerma.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Dispatcher.Interfaces
//, PolyKerma.Dispatcher.Common
, PolyKerma.Messages.Interfaces
, PolyKerma.Modules.Interfaces
;

type
{ TInterfacedDispatcher }
  TInterfacedDispatcher = class(TInterfacedObject, IDispatcher)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Post(const AChannel: String; const AMessage: IMessage);
  published
  end;

implementation

{ TInterfacedDispatcher }

constructor TInterfacedDispatcher.Create;
begin

end;

destructor TInterfacedDispatcher.Destroy;
begin
  inherited Destroy;
end;

function TInterfacedDispatcher.Register(const AChannel: String;
  const AModule: IModule): Boolean;
begin
  Result:= false;
end;

procedure TInterfacedDispatcher.Post(const AChannel: String; const AMessage: IMessage);
begin

end;

end.

