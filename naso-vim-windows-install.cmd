REM    Copyright 2014 Steve Francia
REM 
REM    Licensed under the Apache License, Version 2.0 (the "License");
REM    you may not use this file except in compliance with the License.
REM    You may obtain a copy of the License at
REM 
REM        http://www.apache.org/licenses/LICENSE-2.0
REM 
REM    Unless required by applicable law or agreed to in writing, software
REM    distributed under the License is distributed on an "AS IS" BASIS,
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM    See the License for the specific language governing permissions and
REM    limitations under the License.


@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

set VIMAPP_PATH=%HOME%\naso-vim
IF NOT EXIST "%VIMAPP_PATH%" (
    call git clone https://github.com/nasoundead/naso-vim.git "%VIMAPP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating naso-vim
    chdir /d "%VIMAPP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%VIMAPP_PATH%"
)

call mklink "%HOME%\.vimrc" "%VIMAPP_PATH%\.vimrc"
call mklink "%HOME%\_vimrc" "%VIMAPP_PATH%\.vimrc"
call mklink /J "%HOME%\.vim" "%VIMAPP_PATH%\.vim"


set CONFIG_PATH=%HOME%\AppData\Local
call mklink /J "%CONFIG_PATH%\nvim" "%VIMAPP_PATH%\.vim"
call mklink "%CONFIG_PATH%\nvim\init.vim" "%VIMAPP_PATH%\.vimrc"
call mklink "%CONFIG_PATH%\nvim\ginit.vim" "%VIMAPP_PATH%\ginit.vim"

IF NOT EXIST "%VIMAPP_PATH%\.vim\autoload" (
    call mkdir "%VIMAPP_PATH%\.vim\autoload"
)

IF NOT EXIST "%VIMAPP_PATH%/vim-plug/" (
	call cd "%VIMAPP_PATH%"
    call git clone https://github.com/junegunn/vim-plug.git
	call mklink "%HOME%\.vim\autoload\plug.vim" "%VIMAPP_PATH%\vim-plug\plug.vim"
)ELSE (
  call cd "%HOME%\.vim\autoload\vim-plug"
  call git pull
  call cd %HOME%
  call mklink "%HOME%\.vim\autoload\plug.vim" "%VIMAPP_PATH%\vim-plug\plug.vim"
)

REM call vim PlugUpdate

