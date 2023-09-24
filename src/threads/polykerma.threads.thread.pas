unit PolyKerma.Threads.Thread;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, PolyKerma.Threads.Interfaces
;

type

{ TInterfacedThread }
  TInterfacedThread = class(TThread, IThread)
  protected
    FRefCount : longint;
    FDestroyCount : longint;

    function QueryInterface(
      {$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid : tguid;out obj
    ) : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _AddRef : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _Release : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};

  public
    constructor Create(const CreateSuspended: Boolean); reintroduce;
    destructor Destroy; override;

  end;
  TInterfacedThreadClass = class of TInterfacedThread;

implementation

{ TInterfacedThread }

function TInterfacedThread.QueryInterface(
  {$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid : tguid;out obj
) : longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
begin
  if getinterface(iid,obj) then
    Result:= S_OK
  else
    Result:= longint(E_NOINTERFACE);
end;

function TInterfacedThread._AddRef: longint;
  {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
begin
  Result:= interlockedincrement(FRefCount);
end;

function TInterfacedThread._Release: longint;
  {$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
begin
  Result:=interlockeddecrement(FRefCount);
  if Result = 0 then
    begin
      if interlockedincrement(FDestroyCount)=1 then
        Self.destroy;
    end;
end;

constructor TInterfacedThread.Create(const CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
end;

destructor TInterfacedThread.Destroy;
begin
  inherited Destroy;
end;

end.

