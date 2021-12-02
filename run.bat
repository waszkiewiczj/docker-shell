ECHO OFF

SET DOCKER_SHELL_RELEASE_VERSION=latest
SET DOCKER_SHELL_REGISTRY=ghcr.io/waszkiewiczj/docker-shell
SET DOCKER_SHELL_BASE_TAG=%DOCKER_SHELL_REGISTRY%:%DOCKER_SHELL_RELEASE_VERSION%

:: parameters for local build
SET DOCKER_SHELL_VERSION=
SET DOCKER_SHELL_TARGET=regular
SET DOCKER_SHELL_BUILD=false
SET DOCKER_SHELL_CONTEXT=%~dp0

:processargs
SET ARG=%1
IF DEFINED ARG (
    IF "%ARG%" == "/s" (
        SET DOCKER_SHELL_VERSION=-slim
		SET DOCKER_SHELL_TARGET=slim
        SHIFT
    ) ELSE IF "%ARG%" == "/l" (
        SET DOCKER_SHELL_BUILD=true
		SET DOCKER_SHELL_BASE_TAG=docker-shell
        SHIFT
    ) ELSE IF "%ARG%" == "/t" (
        SHIFT
        SET DOCKER_SHELL_BASE_TAG=%DOCKER_SHELL_REGISTRY%:%2
        SHIFT
    ) ELSE IF "%ARG%" == "/?" (
        CALL :usage
        EXIT /B 0
    ) ELSE  (
        CALL :usage
        EXIT /B 1
    )
    GOTO processargs
)

SET DOCKER_SHELL_TAG=%DOCKER_SHELL_BASE_TAG%%DOCKER_SHELL_VERSION%

IF "%DOCKER_SHELL_BUILD%" == "true" (
    docker build ^
    --progress plain ^
    --target %DOCKER_SHELL_TARGET% ^
    --tag %DOCKER_SHELL_TAG% ^
    %DOCKER_SHELL_CONTEXT%
)

docker run ^
--rm ^
--interactive ^
--tty ^
--privileged ^
--net host ^
--pid host ^
--env HOST_HOME_DIR=/mnt/host%HOMEPATH:\=/% ^
--volume %HOMEDRIVE%\:/mnt/host ^
--volume /var/run/docker.sock:/var/run/docker.sock ^
--env DISPLAY ^
%DOCKER_SHELL_TAG%

EXIT /B 0


:usage
ECHO Run shell inside docker container.
ECHO Usage:
ECHO run.bat [/s] [{/l ^| /d ^| /t ^<tag^>}]
ECHO Options:
ECHO /s - run slim version
ECHO /l - build ^& run local version
ECHO /d - run development version
ECHO /t - run specific version
EXIT /B 0
