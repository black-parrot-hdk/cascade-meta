# Copyright 2023 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

# absolute path we are executing from

if [ "$0" != "$BASH_SOURCE" -a "$BASH_SOURCE" ]
then  # sourced in bash
	myroot=$(dirname $(realpath -- $BASH_SOURCE))
else
	myroot=$(cd $(dirname $0) && pwd -P)
fi

echo "metarepo root: $myroot"

# Set meta repo root
export CASCADE_META_ROOT=$myroot

# Where are the design submodules located
export CASCADE_DESIGN_PROCESSING_ROOT=$CASCADE_META_ROOT/design-processing

# Do not select any design by default
unset CASCADE_DESIGN

# Defaults

# Where to install the binaries and other files of all the tools
# (compiler toolchain, verilator, sv2v, etc.)
export PREFIX_CASCADE=$HOME/prefix-cascade

# How many parallel jobs would you like to have issued?
export CASCADE_JOBS=250 # Feel free to change this

# Where to store a lot of data?
export CASCADE_DATADIR=$CASCADE_META_ROOT/experimental-data # Feel free to change this

# Where the common HDL processing Python scripts are located.
export CASCADE_PYTHON_COMMON=$CASCADE_DESIGN_PROCESSING_ROOT/common/python_scripts

# If you would like to customize some of the settings, add another
# $USER test clause like the one below.

export CASCADE_RISCV_BITWIDTH=64

HOSTNAME=$(hostname)
ulimit -n 10000 # many FD's
export CASCADE_DATADIR=$CASCADE_META_ROOT/cascade-data

# Where should our python venv be?
export CASCADE_PYTHON_VENV=$PREFIX_CASCADE/python-venv

# RISCV toolchain location
export RISCV=$PREFIX_CASCADE/riscv

# Have we been sourced?
export CASCADE_ENV_SOURCED=yes

# Rust settings
export CARGO_HOME=$PREFIX_CASCADE/.cargo
export RUSTUP_HOME=$PREFIX_CASCADE/.rustup

# If we add more variables, let consumers
# of these variables detect it
export CASCADE_ENV_VERSION=1

# Set opentitan path (for Ibex)
export OPENTITAN_ROOT=$myroot/external-dependencies/cascade-opentitan

# Set yosys scripts location
export CASCADE_YS=$CASCADE_DESIGN_PROCESSING_ROOT/common/yosys

# use which compiler?
export CASCADE_GCC=riscv32-unknown-elf-gcc
export CASCADE_OBJDUMP=riscv32-unknown-elf-objdump

# use libstdc++ in this prefix
export LD_LIBRARY_PATH=$PREFIX_CASCADE/lib64:$LD_LIBRARY_PATH

export MPLCONFIGDIR=$PREFIX_CASCADE/matplotlib
mkdir -p $MPLCONFIGDIR

# Make configuration usable; prioritize our tools
PATH=$PREFIX_CASCADE/miniconda/bin:$PATH
PATH=$PREFIX_CASCADE/bin:$PATH
PATH=$PREFIX_CASCADE/bin:$CARGO_HOME/bin:$PREFIX_CASCADE/python-venv/bin/:$PATH
PATH=$RISCV/bin:$PATH

# For cooperative Modelsim locking
export MODELSIM_LOCKFILE=$CASCADE_META_ROOT/tmp/modelsim_lock

# RISC-V proxy kernel
export CASCADE_PK64=$RISCV/riscv32-unknown-elf/bin/pk

export CASCADE_PATH_TO_FIGURES=$CASCADE_META_ROOT/figures

#export CASCADE_BP_SDK_DIR=$CASCADE_META_ROOT/../../../software/import/black-parrot-sdk
#export CASCADE_BP=$CASCADE_META_ROOT/../../import/black-parrot
echo $CASCADE_BP_SDK_DIR
echo $CASCADE_BP
