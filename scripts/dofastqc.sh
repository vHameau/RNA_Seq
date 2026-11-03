#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=01:00:00
#SBATCH --partition=pshort_el8
#SBATCH --job-name=do_fastqc
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%x_%j.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%x_%j.err

BASE="/data/users/${USER}/RNA_Seq"
container="/containers/apptainer/fastqc-0.12.1.sif"

cd ${BASE}/samples/reads_Blood/

apptainer exec \
    ${container} \
    fastqc -o ${BASE}/results/fastqc_res *.fastq.gz