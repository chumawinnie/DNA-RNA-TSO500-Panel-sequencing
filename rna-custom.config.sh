process {
    // Global configuration for all processes
    withName: ".*" {
        time = 72.h
    }

    // Configuration for STAR alignment
    withName: 'NFCORE_RNASEQ:ALIGN_STAR' {
        memory = '64 GB'  // Adjusted memory for STAR
        cpus = 16         // Reduced CPU count
        time = '24h'
    }

    // Configuration for SortMeRNA indexing to prevent memory overuse
    withName: 'SORTMERNA_INDEX' {
        memory = '120 GB'  // Set within system memory limits
        cpus = 16         // Adjusted CPU usage for SortMeRNA
        time = '48h'      // Increased time limit to ensure completion
    }
}

