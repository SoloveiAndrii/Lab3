chcp 65001
@echo off
:: Перевірка, чи передано параметри. Якщо ні, то виведення інструкцій та завершення скрипта
if "%~1"=="" (
    echo Цей скрипт використовується для підрахунку сумарного обсягу файлів в каталозі.
    echo Скрипт може:
    echo 1. Інтерпретувати змінну кількість параметрів командного рядка
    echo 2. Формувати коди завершення
    echo 3. Враховувати атрибути файлів (прихований, тільки читання, архівний)
    echo.
    echo Використання: %~nx0 [каталог1] [каталог2] ...
    echo Наприклад: %~nx0 "C:\Users\Андрей\Desktop" "D:\Новая папка"
    echo.
)
@echo off
:loop
if "%~1"=="" goto :end
set "directory=%~1"
echo Обробка каталогу: "%directory%"
set /a totalSize=0
set /a hiddenFilesSize=0
set /a readOnlyFilesSize=0
set /a archiveFilesSize=0
	
for /R "%directory%" %%F in (*) do (
    set /a fileSize=%%~zF/1024
    set /a totalSize+=fileSize
    if %%~aF lss -h (
        set /a hiddenFilesSize+=fileSize
    )
    if %%~aF lss -r (
        set /a readOnlyFilesSize+=fileSize
    )
    if %%~aF lss -a (
        set /a archiveFilesSize+=fileSize
    )
)
echo.
echo Сумарний обсяг файлів в каталозі "%directory%": %totalSize% КБ
echo Сумарний обсяг прихованих файлів: %hiddenFilesSize% КБ
echo Сумарний обсяг файлів тільки для читання: %readOnlyFilesSize% КБ
echo Сумарний обсяг архівних файлів: %archiveFilesSize% КБ
echo.
shift
goto :loop
:end
pause
exit  /b %errorlevel%