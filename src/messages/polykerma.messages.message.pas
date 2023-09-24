unit PolyKerma.Messages.Message;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Messages.Interfaces
;

type
{ TMessage }
  TMessage = class(TInterfacedObject, IMessage)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

  published
  end;

implementation

{ TDispatcher }

constructor TMessage.Create;
begin

end;

destructor TMessage.Destroy;
begin
  inherited Destroy;
end;

end.


