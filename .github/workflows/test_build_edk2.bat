@REM @file
@REM
@REM Script to check compilation of EDK2
@REM
@REM Copyright (c) Microsoft Corporation
@REM SPDX-License-Identifier: BSD-2-Clause-Patent
@REM

echo "Checking EDKII Build."

@REM if (Test-Path -Path 'edk2') {
@REM   Write-Output "Deleting existing EDK2 repo."
@REM   Remove-Item 'edk2' -Recurse
@REM }

git clone --depth=1 "https://github.com/tianocore/edk2.git"
cd edk2

# Upgrade pip and install dependencies.
python -m pip install --upgrade pip
python -m pip install --upgrade -r pip-requirements.txt

# Prepare repository
stuart_setup -c .pytool/CISettings.py
stuart_update -c .pytool/CISettings.py

python BaseTools/Edk2ToolsBuild.py -t VS2022

echo "-----------------------------------------------------------------"
echo " Building CI for X64"
echo "-----------------------------------------------------------------"
stuart_ci_build -c .\CISettings.py TOOL_CHAIN_TAG=VS2022
