process {
    withName: ".*" {
        time = 72.h
    }

    // Allocate more memory and CPUs for STAR_ALIGN process
    withName: 'NFCORE_ONCOANALYSER:TARGETED:READ_ALIGNMENT_RNA:STAR_ALIGN' {
        memory = '70 GB'
        cpus = 4
    }
}
