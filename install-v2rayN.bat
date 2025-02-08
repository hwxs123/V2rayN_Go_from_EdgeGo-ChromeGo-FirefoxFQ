@echo off&color F0
setlocal enabledelayedexpansion

rem ��ȡ��ǰ�û��� Documents �ļ���·��
set "documents_folder=%USERPROFILE%\Documents"

rem ��ȡ����·��
set "desktop_folder=%USERPROFILE%\Desktop"

rem ��鲢��ѹ v2rayN-windows-64.zip �� Documents �ļ���
if exist "v2rayN-windows-64.zip" (
    echo ���ڽ�ѹ v2rayN-windows-64.zip �� %documents_folder%
    powershell -command "Expand-Archive -Path 'v2rayN-windows-64.zip' -DestinationPath '%documents_folder%' -Force"
    if !errorlevel! equ 0 (
        echo v2rayN-windows-64.zip ��ѹ�ɹ�
    ) else (
        echo v2rayN-windows-64.zip ��ѹʧ��
    )
)
if exist "%USERPROFILE%\Documents\v2rayN-windows-64" (set "v2rayn_path=%USERPROFILE%\Documents\v2rayN-windows-64" &goto found)
rem ��鲢��ѹ v2rayN-guiConfigs.zip �� v2rayN.exe �����ļ���
if exist "v2rayN-guiConfigs.zip" (
    echo ����C�̻�D������ v2rayN.exe �����ļ���
    set "v2rayn_path="
    for %%i in (D: C:) do (
        for /f "delims=" %%j in ('dir /s /b "%%i\v2rayN.exe" 2^>nul') do (
            set "v2rayn_path=%%~dpj"
            goto found
        )
    )
:found
    if defined v2rayn_path (
        echo ���ڽ�ѹ v2rayN-guiConfigs.zip �� %v2rayn_path%
        powershell -command "Expand-Archive -Path 'v2rayN-guiConfigs.zip' -DestinationPath '%v2rayn_path%' -Force"
        if !errorlevel! equ 0 (
            echo v2rayN-guiConfigs.zip ��ѹ�ɹ�
        ) else (
            echo v2rayN-guiConfigs.zip ��ѹʧ��
        )
    ) else (
        echo δ�ҵ� v2rayN.exe �����ļ��У��޷���ѹ v2rayN-guiConfigs.zip
    )
)

rem ���� v2rayn.exe �������ݷ�ʽ
set "v2rayn_exe_path=%v2rayn_path%\v2rayN.exe"
if exist "%v2rayn_exe_path%" (
    echo ���ڴ��� %v2rayn_exe_path% �������ݷ�ʽ
    powershell -command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%desktop_folder%\v2rayN.lnk'); $Shortcut.TargetPath = '%v2rayn_path%\v2rayn.exe'; $Shortcut.Save()"
    if !errorlevel! equ 0 (
        echo %v2rayn_exe_path% �������ݷ�ʽ�����ɹ�
    ) else (
        echo %v2rayn_exe_path% �������ݷ�ʽ����ʧ��
    )
)

rem ���� v2rayN_go.lnk �������ݷ�ʽ
set "v2rayn_go_lnk_path=%v2rayn_path%\guiConfigs\v2rayN_go.lnk"
if exist "%v2rayn_go_lnk_path%" (
    echo ���ڴ��� %v2rayn_go_lnk_path% �������ݷ�ʽ
    powershell -command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%desktop_folder%\v2rayN_go.lnk'); $Shortcut.TargetPath = '%v2rayn_path%\guiConfigs\v2rayN_go.bat'; $shortcut.IconLocation = '%SystemRoot%\System32\SHELL32.dll,14';$Shortcut.Save()"
    if !errorlevel! equ 0 (
        echo %v2rayn_go_lnk_path% �������ݷ�ʽ�����ɹ�
    ) else (
        echo %v2rayn_go_lnk_path% �������ݷ�ʽ����ʧ��
    )
)

rem ��鲢���� windowsdesktop-runtime-8.0.12-win-x64.exe
if exist "windowsdesktop-runtime-8.0.12-win-x64.exe" (
    echo �������� windowsdesktop-runtime-8.0.12-win-x64.exe
    start "" "windowsdesktop-runtime-8.0.12-win-x64.exe"
)

endlocal
echo �ű�ִ�����