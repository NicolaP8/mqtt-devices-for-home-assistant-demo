program tester;

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, DebugMe, SystemLog;

Const
  cfgScreenLogLines = 10;

type
  { TTester }
  TTester = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TTester }

procedure TTester.DoRun;
var
  ErrorMsg: String;
  i : integer;
begin
  // quick check parameters
  ErrorMsg := CheckOptions('h', 'help');
  if ErrorMsg <> '' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }
  ErrorMsg := '{"device_class": "temperature", "icon": "hass:thermometer", "name": "Temperatura", "suggested_display_precision": "1", "qos": "0", "state_class": "measurement", "state_topic": "homeassistant/sensor/demo_device_001/temperature", "unique_id": "demo_device_001_temp", "unit_of_measurement": "°C", "device": {"identifiers": ["demo_device_001"], "manufacturer": "Nicola", "model": "Delphi/Lazarus/Fpc", "name": "Demo Device", "sw_version": "0.1"}}';
  PrintDebug(LOG_DEBUG, '[Test]', ErrorMsg);
  readln;

  PrintDebug(LOG_DEBUG, '[Test]', 'secondo messaggio');
  PrintDebug(LOG_DEBUG, '[Test]', 'terzo messaggio, lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo');
  PrintDebug(LOG_DEBUG, '[Test]', 'quarto messaggio, lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo lungo ma lungo!');
  readln;

  ErrorMsg := '{"device_class": "temperature", "icon": "hass:thermometer", "name": "Temperatura", "suggested_display_precision": "1", "qos": "0", "state_class": "measurement", "state_topic": "homeassistant/sensor/demo_device_001/temperature", "unique_id": "demo_device_001_temp", "unit_of_measurement": "°C", "device": {"identifiers": ["demo_device_001"], "manufacturer": "Nicola", "model": "Delphi/Lazarus/Fpc", "name": "Demo Device", "sw_version": "0.1"}}';
  PrintDebug(LOG_DEBUG, '[Test]', ErrorMsg);
  readln;

  // stop program loop
  Terminate;
end;

constructor TTester.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TTester.Destroy;
begin
  inherited Destroy;
end;

procedure TTester.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TTester;
begin
  cfgDebugWindow[0] := 1;
  cfgDebugWindow[1] := 1;
  cfgDebugWindow[2] := 60;
  cfgDebugWindow[3] := cfgScreenLogLines;
  cfgDebugLevel   := LOG_DEBUG; //massimo livello: mostra tutti i messaggi
  cfgDebugConsole := True;
  cfgDebugSyslog  := False;
  cfgDebugProgramId := 'Tester';
  DebugScrollEnable;

  Application:=TTester.Create(nil);
  Application.Title:='Tester';
  Application.Run;
  Application.Free;
end.

