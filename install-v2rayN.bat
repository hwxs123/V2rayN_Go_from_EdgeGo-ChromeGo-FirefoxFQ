@echo off&color F0
setlocal enabledelayedexpansion

rem 获取当前用户的 Documents 文件夹路径
set "documents_folder=%USERPROFILE%\Documents"

rem 获取桌面路径
set "desktop_folder=%USERPROFILE%\Desktop"

rem 检查并解压 v2rayN-windows-64.zip 到 Documents 文件夹
if exist "v2rayN-windows-64.zip" (
    echo 正在解压 v2rayN-windows-64.zip 到 %documents_folder%
    powershell -command "Expand-Archive -Path 'v2rayN-windows-64.zip' -DestinationPath '%documents_folder%' -Force"
    if !errorlevel! equ 0 (
        echo v2rayN-windows-64.zip 解压成功
    ) else (
        echo v2rayN-windows-64.zip 解压失败
    )
)
if exist "%USERPROFILE%\Documents\v2rayN-windows-64" (set "v2rayn_path=%USERPROFILE%\Documents\v2rayN-windows-64" &goto found)
rem 检查并解压 v2rayN-guiConfigs.zip 到 v2rayN.exe 所在文件夹
if exist "v2rayN-guiConfigs.zip" (
    echo 正在C盘或D盘搜索 v2rayN.exe 所在文件夹
    set "v2rayn_path="
    for %%i in (D: C:) do (
        for /f "delims=" %%j in ('dir /s /b "%%i\v2rayN.exe" 2^>nul') do (
            set "v2rayn_path=%%~dpj"
            goto found
        )
    )
:found
    if defined v2rayn_path (
        echo 正在解压 v2rayN-guiConfigs.zip 到 %v2rayn_path%
        powershell -command "Expand-Archive -Path 'v2rayN-guiConfigs.zip' -DestinationPath '%v2rayn_path%' -Force"
        if !errorlevel! equ 0 (
            echo v2rayN-guiConfigs.zip 解压成功
        ) else (
            echo v2rayN-guiConfigs.zip 解压失败
        )
    ) else (
        echo 未找到 v2rayN.exe 所在文件夹，无法解压 v2rayN-guiConfigs.zip
    )
)

rem 创建 v2rayn.exe 的桌面快捷方式
set "v2rayn_exe_path=%v2rayn_path%\v2rayN.exe"
if exist "%v2rayn_exe_path%" (
    echo 正在创建 %v2rayn_exe_path% 的桌面快捷方式
    powershell -command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%desktop_folder%\v2rayN.lnk'); $Shortcut.TargetPath = '%v2rayn_path%\v2rayn.exe'; $Shortcut.Save()"
    if !errorlevel! equ 0 (
        echo %v2rayn_exe_path% 的桌面快捷方式创建成功
    ) else (
        echo %v2rayn_exe_path% 的桌面快捷方式创建失败
    )
)

rem 创建 v2rayN_go.lnk 的桌面快捷方式
set "v2rayn_go_lnk_path=%v2rayn_path%\guiConfigs\v2rayN_go.lnk"
if exist "%v2rayn_go_lnk_path%" (
    echo 正在创建 %v2rayn_go_lnk_path% 的桌面快捷方式
    powershell -command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%desktop_folder%\v2rayN_go.lnk'); $Shortcut.TargetPath = '%v2rayn_path%\guiConfigs\v2rayN_go.bat'; $shortcut.IconLocation = '%SystemRoot%\System32\SHELL32.dll,14';$Shortcut.Save()"
    if !errorlevel! equ 0 (
        echo %v2rayn_go_lnk_path% 的桌面快捷方式创建成功
    ) else (
        echo %v2rayn_go_lnk_path% 的桌面快捷方式创建失败
    )
)

rem 检查并运行 windowsdesktop-runtime-8.0.12-win-x64.exe
if exist "windowsdesktop-runtime-8.0.12-win-x64.exe" (
    echo 正在运行 windowsdesktop-runtime-8.0.12-win-x64.exe
    start "" "windowsdesktop-runtime-8.0.12-win-x64.exe"
)

endlocal
echo 脚本执行完毕