#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --partition=pshort_el8
#SBATCH --job-name=samtools_indexing
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --account=class-467713-ws-2026
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%x_%j.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%x_%j.err

#variables
RESULTPATH="/data/users/${USER}/RNA_Seq/results/mapping"
container="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"

#moving to directory containing the sorted(!) .bam files
cd ${RESULTPATH}

#for loop because samtools indexing can't handle *.bam directly
for i in *.bam
do
    apptainer exec \
    ${container} \
    samtools index ${i}
done