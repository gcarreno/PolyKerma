unit PolyKerma.Messages.Message;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Messages.Interfaces
;

type
{ TInterfacedMessage }
  TInterfacedMessage = class(TInterfacedObject, IMessage)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TDispatcher }

constructor TInterfacedMessage.Create;
begin

end;

destructor TInterfacedMessage.Destroy;
begin
  inherited Destroy;
end;

end.


