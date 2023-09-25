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

    function GetChannel: String;
  protected
  public
    constructor Create(const AChannel: String);
    destructor Destroy; override;

    property Channel: String
      read GetChannel;
  published
  end;
  TInterfacedMessageClass = class of TInterfacedMessage;

implementation

{ TDispatcher }

function TInterfacedMessage.GetChannel: String;
begin
  Result:= FChannel;
end;

constructor TInterfacedMessage.Create(const AChannel: String);
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s', [ AChannel ]));
  FChannel:= AChannel;
end;

destructor TInterfacedMessage.Destroy;
begin
  DebugLn({$I %FILE%}, {$I %LINE%}, 'Message Destroy');
  inherited Destroy;
end;

end.


