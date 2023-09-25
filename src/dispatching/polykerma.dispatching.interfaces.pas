unit PolyKerma.Dispatching.Interfaces;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
, PolyKerma.Modules.Interfaces
;

type
{ IDispatcher }
  IDispatcher = Interface
  ['{1CD54522-D37B-486E-9181-A97CCF768DE9}']
    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Post(const AMessage: IMessage);
    procedure ProcessMessage(const AMessage: IMessage);
  end;

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
