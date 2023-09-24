unit PolyKerma.Dispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Dispatcher.Interfaces
;

type
{ TDispatcher }
  TDispatcher = class(TInterfacedObject, IDispatcher)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

    function Register(const AChannel: String{, const AModule: IModule}): Boolean;
    procedure Post(const AChannel: String{, const AMessage: IMessage});
  published
  end;

implementation

{ TDispatcher }

constructor TDispatcher.Create;
begin

end;

destructor TDispatcher.Destroy;
begin
  inherited Destroy;
end;

function TDispatcher.Register(const AChannel: String): Boolean;
begin
  Result:= false;
end;

procedure TDispatcher.Post(const AChannel: String);
begin

end;

end.

