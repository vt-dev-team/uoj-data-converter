; This file is copied from CP Editor and then modified

; Before running define these three variables is must.
; MyRootOut = directory where you ran windeployqt
; MyAppVersion = App Version
; MyProjectRoot = Source root

#define MyAppName "UOJ Data Converter"
#define MyAppPublisher "Yufan You <ouuan>"
#define MyAppURL "https://github.com/ouuan/uoj-data-converter"
#define MyAppExeName "uoj-data-converter.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{9B09A284-71BF-4585-8BA9-E6B8166A63B6}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\uoj-data-converter
DisableProgramGroupPage=yes
UsedUserAreasWarning=no
LicenseFile={#MyProjectRoot}\LICENSE
PrivilegesRequiredOverridesAllowed=dialog
OutputDir={#MyProjectRoot}
OutputBaseFilename=uoj-data-converter-{#MyAppVersion}-windows-x64-setup
SetupIconFile={#MyProjectRoot}\.ci\win\icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
Source: "{#MyOutRoot}\uoj-data-converter.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyOutRoot}\iconengines\*"; DestDir: "{app}\iconengines\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyOutRoot}\imageformats\*"; DestDir: "{app}\imageformats\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyOutRoot}\platforms\*"; DestDir: "{app}\platforms\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyOutRoot}\styles\*"; DestDir: "{app}\styles\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyOutRoot}\*.dll"; DestDir: "{app}"; Flags: ignoreversion

; VC++ redistributable runtime. Extracted by VC2019RedistNeedsInstall(), if needed.
Source: "{#MyOutRoot}\Redist\vc_redist.x64.exe"; DestDir: {tmp}; Flags: dontcopy

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "{tmp}\vc_redist.x64.exe"; StatusMsg: "Installing VC2019 redist..."; Parameters: "/quiet"; Check: VC2019RedistNeedsInstall ; Flags: waituntilterminated

[Code]
function VC2019RedistNeedsInstall: Boolean;
var
  Version: String;
  ExpectedVersion: String;
begin
  if (RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Version', Version)) then
  begin
    ExpectedVersion := 'v{#VC_REDIST_VERSION}.03'
    Log('VC Redist Version check : found ' + Version);
    Log('VC Redist Version check : expected ' + ExpectedVersion);
    Result := (CompareStr(Version, ExpectedVersion)<0);
  end
  else
  begin
    // Not even an old version installed
    Result := True;
  end;
  if (Result) then
  begin
    ExtractTemporaryFile('vc_redist.x64.exe');
  end;
end;
