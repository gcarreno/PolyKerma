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
;

type
{ TMessage }
  TMessage = class(TObject)
  private
    FChannel: String;
    FPayload: String;

  protected
  public
    constructor Create(const AChannel: String);
    destructor Destroy; override;

    property Channel: String
      read FChannel;
    property Payload: String
      read FPayload
      write FPayload;
  published
  end;
  TMessageClass = class of TMessage;

implementation

{ TMessage }

constructor TMessage.Create(const AChannel: String);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s', [ AChannel ]));
  FChannel:= AChannel;
end;

destructor TMessage.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Message Destroy');
  inherited Destroy;
end;

end.


