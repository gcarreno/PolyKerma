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
, PolyKerma.Dispatching
, PolyKerma.Logging
;

type
{ TMessage }
  TMessage = class(TObject)
  private
    FAttachment: String;
    FChannel: String;
    FText: String;
    FAttachement: TObject;

  protected
  public
    constructor Create;
    constructor Create(
      const AChannel: String);
    constructor Create(
      const AChannel: String;
      const AText: String);
    constructor Create(
      const AChannel: String;
      const AText: String;
      const AAttachement: TObject);
    destructor Destroy; override;

    function Copy: TMessage;

    property Channel: String
      read FChannel;
    property Text: String
      read FText
      write FText;
    property Attachment: String
      read FAttachment
      write FAttachment;
  published
  end;
  TMessageClass = class of TMessage;

implementation

{ TMessage }

constructor TMessage.Create;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Message Create');
  FChannel:= cChannelNone;
  FText:= EmptyStr;
  FAttachement:= nil;
end;

constructor TMessage.Create(
  const AChannel: String);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s', [ AChannel ]));
  FChannel:= AChannel;
end;

constructor TMessage.Create(
  const AChannel: String;
  const AText: String);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s, "%s"', [
    AChannel,
    AText
  ]));
  FChannel:= AChannel;
  FText:= AText;
end;

constructor TMessage.Create(
  const AChannel: String;
  const AText: String;
  const AAttachement: TObject);
begin
  Debug({$I %FILE%}, {$I %LINE%}, Format('Message Create: %s, "%s"', [
    AChannel,
    AText
  ]));
  FChannel:= AChannel;
  FText:= AText;
end;

destructor TMessage.Destroy;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Message Destroy');
  inherited Destroy;
end;

function TMessage.Copy: TMessage;
begin
  Debug({$I %FILE%}, {$I %LINE%}, 'Message Copy');
  Result:= TMessage.Create(Self.Channel);
  Result.FChannel:= Self.FChannel;
  Result.FText:= Self.FText;
  Result.FAttachement:= Self.FAttachement;
end;

end.


