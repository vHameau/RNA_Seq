#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=35G
#SBATCH --time=04:00:00
#SBATCH --array=1-15%2
#SBATCH --partition=pibu_el8
#SBATCH --job-name=mapping_sorting
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --account=class-467713-ws-2026
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%A_%a.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%A_%a.err

set -euo pipefail

#variables
RESULTPATH="/data/users/${USER}/RNA_Seq/results/mapping"
BASE="/data/users/${USER}/RNA_Seq"
container="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"
sample=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "${BASE}/samples/reads_Blood/SRR_Acc_List.txt")

#moving to previously created folder
cd ${BASE}

#starting the code
apptainer exec ${container} bash -o pipefail -c "\
    hisat2 -p 4 -x resources/index_mouse \
    -1 'samples/reads_Blood/${sample}_1.fastq.gz' \
    -2 'samples/reads_Blood/${sample}_2.fastq.gz' \
    --rna-strandness RF | \
    samtools sort -@ 3 -m 6G \
    -o '${RESULTPATH}/${sample}.sorted.bam' "
