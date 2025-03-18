# Docker Image for Bioinformatics Tools

## Installed Tools
This Docker image contains the following bioinformatics tools:

1. **bwa-mem2** (v2.2.1)
2. **samtools** (v1.17)
3. **multiqc** (v1.17)
4. **picard** (v3.0.0)

## Building the Docker Image
To build the Docker image, run the following command:

```sh
docker build -t bioinfo-tools .
```

## Running the Container
To start an interactive session inside the container:

```sh
docker run --rm -it bioinfo-tools
```

To mount a directory from the host system (for example, `/mnt/8Tb_new/vvolk/task_1/`):

```sh
docker run --rm -it -v /mnt/8Tb_new/vvolk/task_1/:/data bioinfo-tools
```

## Testing Installed Tools
### Check installed versions:

```sh
samtools --version
$SAMTOOLS --version
multiqc --version
$MULTIQC --version
java -jar $PICARD -version
$BWAMEM2 version
```

### Example Pipeline Execution
Run bwa-mem2 and samtools on an example FASTQ file:

```sh
bwa-mem2 mem -t 8 reference.fa /data/sample.fq.gz > /data/sample.sam
samtools view -Sb /data/sample.sam > /data/sample.bam
samtools sort /data/sample.bam -o /data/sample_sorted.bam
```

### Notes
- The `$TOOLS` environment variable points to `/tools/`, where all specialized bioinformatics tools are installed.
- Each tool's full path is stored in an uppercase-named environment variable (e.g., `$SAMTOOLS`, `$BWAMEM2`).

