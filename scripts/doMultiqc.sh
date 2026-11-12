#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=01:00:00
#SBATCH --partition=pshort_el8
#SBATCH --job-name=do_multiqc
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --account=class-467713-ws-2026
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%x_%j.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%x_%j.err

RESULTPATH="/data/users/vhameau/RNA_Seq/results/multiqc"
BASE="/data/users/${USER}/RNA_Seq"
container="/containers/apptainer/multiqc-1.33.sif"

cd ${BASE}/results/fastqc_res

apptainer exec \
    ${container} \
    multiqc -o ${RESULTPATH} .


