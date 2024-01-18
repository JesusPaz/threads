const { Worker } = require('worker_threads');

function startWorker(path, cb) {
    const worker = new Worker(path);
    worker.on('message', (msg) => cb(null, msg));
    worker.on('error', cb);
    worker.on('exit', (code) => {
        if (code !== 0) cb(new Error(`Worker stopped with exit code ${code}`));
    });
}

const numThreads = 10000;
for (let i = 0; i < numThreads; i++) {
    startWorker('./worker.js', (err, result) => {
        if (err) return console.error(err);
        console.log(result);
    });
}
