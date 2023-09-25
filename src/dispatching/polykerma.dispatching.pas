unit PolyKerma.Dispatching;

{$mode objfpc}{$H+}

interface

(*uses
{$IFDEF FPC_DOTTEDUNITS}
  System.Classes
{$ELSE FPC_DOTTEDUNITS}
  Classes
{$ENDIF FPC_DOTTEDUNITS}
;*)

const
  cChannelControllerOut = 'controller.out';
  cChannelControllerIn  = 'controller.in';
  cChannelCommsOut      = 'comms.out';
  cChannelCommsIn       = 'comms.in';
  cChannelModelOut      = 'model.out';
  cChannelModelIn       = 'model.in';

  { #todo -ogcarreno -cexample : Remove after testing }
  cChannelModuleOut      = 'module.out';
  cChannelModuleIn       = 'module.in';

implementation

end.
