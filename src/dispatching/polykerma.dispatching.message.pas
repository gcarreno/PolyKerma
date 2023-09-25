unit PolyKerma.Dispatching.Message;

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
, PolyKerma.Logging
, PolyKerma.Dispatching.Interfaces
;

type
{ TInterfacedMessage }
  TInterfacedMessage = class(TInterfacedObject, IMessage)
  private
    FChannel: String;
    FPayload: String;

    function GetChannel: String;
    function GetPayload: String;
    procedure SetPayload(const APayload: String);

  protected
  public
    constructor Create(const AChannel: String);
    destructor Destroy; override;

    property Channel: String
      read GetChannel;
    property Payload: String
      read GetPayload
      write SetPayload;
  published
  end;
  TInterfacedMessageClass = class of TInterfacedMessage;

implementation

{ TDispatcher }

function TInterfacedMessage.GetChannel: String;
begin
  Result:= FChannel;
end;

function TInterfacedMessage.GetPayload: String;
begin
  Result:= FPayload;
end;

procedure TInterfacedMessage.SetPayload(const APayload: String);
begin
  if FPayload = APayload then exit;
  FPayload:= APayload;
end;

constructor TInterfacedMessage.Create(const AChannel: String);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s', [ AChannel ]));
  FChannel:= AChannel;
end;

destructor TInterfacedMessage.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Message Destroy');
  inherited Destroy;
end;

end.


