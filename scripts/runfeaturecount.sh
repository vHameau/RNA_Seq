#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1000M
#SBATCH --time=02:00:00
#SBATCH --partition=pibu_el8
#SBATCH --job-name=feature_count
#SBATCH --mail-user=victor.hameau@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --account=class-467713-ws-2026
#SBATCH --output=/data/users/vhameau/RNA_Seq/logs/output/%x_%j.out
#SBATCH --error=/data/users/vhameau/RNA_Seq/logs/error/%x_%j.err

#variables
RESULTPATH="/data/users/${USER}/RNA_Seq/results/featurecount"
BASE="/data/users/${USER}/RNA_Seq"
container="/containers/apptainer/subread_2.0.6.sif"
gtf="/data/users/${USER}/RNA_Seq/resources/Mus_musculus.GRCm39.116.gtf.gz"

cd ${BASE}/results/mapping

apptainer exec \
    ${container} \
    featureCounts -T 4 -t exon -g gene_id \
    -a ${gtf} -s 2 -p --countReadPairs \
    -o ${RESULTPATH}/counts.txt *.bam