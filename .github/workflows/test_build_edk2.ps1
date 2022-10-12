## @file
#
# Script to check compilation of EDK2
#
# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

if (Test-Path -Path 'edk2') {
  Write-Output "Deleting existing EDK2 repo."
  Remove-Item 'edk2' -Recurse
}

git clone --depth=1 "https://github.com/tianocore/edk2.git"
cd edk2

# Upgrade pip and install dependencies.
python -m pip install --upgrade pip
python -m pip install --upgrade -r pip-requirements.txt

# Prepare repository
stuart_setup -c .pytool/CISettings.py
stuart_update -c .pytool/CISettings.py

python BaseTools/Edk2ToolsBuild.py -t VS2022

Write-Output "-----------------------------------------------------------------"
Write-Output "Building CI for X64"
Write-Output "-----------------------------------------------------------------"
stuart_ci_build -c .\CISettings.py TOOL_CHAIN_TAG=VS2022
