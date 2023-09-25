unit PolyKerma.Dispatcher.Interfaces;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Messages.Interfaces
, PolyKerma.Modules.Interfaces
;

type
{ IDispatcher }
  IDispatcher = Interface
  ['{1CD54522-D37B-486E-9181-A97CCF768DE9}']
    function Register(const AChannel: String; const AModule: IModule): Boolean;
    procedure Post(const AMessage: IMessage);
  end;

implementation

end.
