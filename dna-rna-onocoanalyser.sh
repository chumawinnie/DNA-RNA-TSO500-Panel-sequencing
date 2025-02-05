nextflow run nf-core/oncoanalyser -r 1.0.0 -profile docker \
  --input /home/obiorach/uka@TSO500/sample-DNA-RNA-oncoanalyzer.csv \
  --outdir /home/obiorach/uka@TSO500/output-DNA-RNA-tso500 \
  --genome GRCh37_hmf \
  --mode targeted \
  --panel tso500 \
  --max_cpus 20 \
  --max_memory '70.GB' \
  -c /home/obiorach/uka@TSO500/custom.config \
  -resume
