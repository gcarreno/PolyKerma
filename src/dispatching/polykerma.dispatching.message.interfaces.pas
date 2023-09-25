unit PolyKerma.Dispatching.Message.Interfaces;

{$mode ObjFPC}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
;

type
{ IMessage }
  IMessage = Interface
  ['{62E0D2A6-6AEE-42DF-BADD-D210BA7A2BD1}']
    function GetChannel: String;

    function GetPayload: String;
    procedure SetPayload(const APayload: String);

    property Channel: String
      read GetChannel;
   property Payload: String
      read GetPayload
      write SetPayload;
  end;


implementation

end.

