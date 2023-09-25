unit PolyKerma.Test.Messages;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, fpcunit
//, testutils
, testregistry
, PolyKerma.Dispatcher.Common
, PolyKerma.Messages.Interfaces
, PolyKerma.Messages.Message
;

type

  TTestMessages= class(TTestCase)
  private
    FMessage: IMessage;
  protected
  public
  published
    procedure TestMessageCreate;
  end;

implementation

procedure TTestMessages.TestMessageCreate;
begin
  FMessage:= TInterfacedMessage.Create(cDispatcherChannelModuleIn);
  AssertNotNull('Message not null', FMessage);
end;



initialization

  RegisterTest(TTestMessages);
end.

