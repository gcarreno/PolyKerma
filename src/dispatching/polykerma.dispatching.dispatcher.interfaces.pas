unit PolyKerma.Dispatching.Dispatcher.Interfaces;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
, PolyKerma.Dispatching.Message.Interfaces
, PolyKerma.Modules.Interfaces
;

type
{ IDispatcher }
  IDispatcher = Interface
  ['{1CD54522-D37B-486E-9181-A97CCF768DE9}']
    procedure Post(const AMessage: IMessage);
    procedure ProcessMessage(const AMessage: IMessage);
    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Run(const WaitFor: Boolean);
  end;

implementation

end.
