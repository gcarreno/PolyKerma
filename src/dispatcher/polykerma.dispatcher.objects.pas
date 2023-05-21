unit PolyKerma.Dispatcher.Objects;

{$mode objfpc}{$H+}

interface

uses
  Classes
, PolyKerma.Dispatcher.Interfaces
;

type
{ TThreadSafeMessageQueue }
  TThreadSafeMessageQueue = class(TInterfacedObject, IThreadSafeMessageQueue)
  private
  protected
  public
  published
  end;

{ TDispatcher }
  TDispatcher = class(TInterfacedObject, IDispatcher)
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;
  published
  end;

implementation

{ TDispatcher }

constructor TDispatcher.Create;
begin

end;

destructor TDispatcher.Destroy;
begin
  inherited Destroy;
end;

end.

