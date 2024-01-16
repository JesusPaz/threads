const { Worker } = require('worker_threads');

function main() {
    const numThreads = 1;

    for (let i = 0; i < numThreads; i++) {
        new Worker('./worker.js');
    }
}

main();
