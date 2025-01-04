# Copyright 2023 Flavien Solt, ETH Zurich.
# Licensed under the General Public License, Version 3.0, see LICENSE for details.
# SPDX-License-Identifier: GPL-3.0-only

# This script generates many Cascade ELFs.

from analyzeelfs.genmanyelfs import gen_many_elfs
from params.runparams import PATH_TO_TMP

import os
import sys
import json

if __name__ == '__main__':
    if "CASCADE_ENV_SOURCED" not in os.environ:
        raise Exception("The Cascade environment must be sourced prior to running the Python recipes.")
    nbfname = 'fuzz0'
    num_elfs = 500
    target_dir = os.path.join(PATH_TO_TMP, 'manyelfs')
    if len(sys.argv) > 1:
        json_string = sys.argv[1]
        isa_class_p_distr = json.loads(json_string)
    else:
        isa_class_p_distr = [0.5]*27
    print("ISA dist:", isa_class_p_distr)
    
    if len(sys.argv) > 2:
        num_elfs = int(sys.argv[2])
    if len(sys.argv) > 3:
        target_dir = sys.argv[3]
    if len(sys.argv) > 4:
        nbfname = sys.argv[4]

    num_cores = int(os.getenv('CASCADE_JOBS', 160))

    gen_many_elfs('bp', num_cores, num_elfs, target_dir, isa_class_p_distr=isa_class_p_distr, nbfname=nbfname)

else:
    raise Exception("This module must be at the toplevel.")
