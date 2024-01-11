const { Worker } = require('worker_threads');

function main() {
    const numThreads = 10000;

    for (let i = 0; i < numThreads; i++) {
        new Worker('./worker.js');
    }
}

main();
