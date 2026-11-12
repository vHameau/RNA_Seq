#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=03:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=do_indexing
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --account=class-467713-ws-2026
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%x_%j.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%x_%j.err


BASE="/data/users/${USER}/RNA_Seq"
container="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"

cd ${BASE}/resources/

apptainer exec \
    ${container} \
    hisat2-build *.fa index_mouse