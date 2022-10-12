# Dockerfile for building container images for use in the EDK2 CI.
#
# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: BSD-2-Clause-Patent
#
# This dockerfile contains the definitions for building and testing EDKII based
# firmare projects in VS2022 on Windows. This image is inteded to be used on
# X64.

FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS build

# Links for installed downloads.
ARG PYTHON_LINK=https://www.python.org/ftp/python/3.10.6/python-3.10.6-amd64.exe
ARG GIT_LINK=https://github.com/git-for-windows/git/releases/download/v2.37.2.windows.2/Git-2.37.2.2-64-bit.exe

# Setup CMD as default shell.
SHELL ["cmd", "/S", "/C"]

# Install VS2022
RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe \
    && vs_buildtools.exe --quiet --wait --norestart --nocache --installPath C:\BuildTools \
           --add Microsoft.VisualStudio.Component.VC.CoreBuildTools \
           --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
           --add Microsoft.VisualStudio.Component.Windows11SDK.22000 \
           --add Microsoft.VisualStudio.Component.VC.Tools.ARM \
           --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 \
    && del /q vs_buildtools.exe

# Install Python3
RUN curl -SL --output python_install.exe %PYTHON_LINK% \
    && python_install.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 Include_tcltk=0 Include_doc=0 \
    && del /q python_install.exe

# Install Git
RUN curl -SL --output git_install.exe %GIT_LINK% \
    && git_install.exe /verysilent /norestart /nocancel /simple \
    && del /q git_install.exe

# Install NodeJS
RUN msiexec.exe /i https://nodejs.org/dist/v16.17.0/node-v16.17.0-x64.msi /quiet

# Install NPM tools
RUN npm install -g npm markdownlint-cli cspell
