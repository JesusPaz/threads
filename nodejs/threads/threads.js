const { Worker, isMainThread, parentPort } = require('worker_threads');

function startWorker(path, cb) {
    const worker = new Worker(path);
    worker.on('message', (msg) => cb(null, msg));
    worker.on('error', cb);
    worker.on('exit', (code) => {
        if (code !== 0)
            cb(new Error(`Worker stopped with exit code ${code}`));
    });
    return worker;
}

if (isMainThread) {
    const numThreads = 4;

    for (let i = 0; i < numThreads; i++) {
        startWorker(__filename, (err, result) => {
            if (err) return console.error(err);
            console.log(result);
        });
    }

} else {
    async function performSimpleOperation() {
        while (true) {
            let _ = 42 * 42;
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
    }

    performSimpleOperation().then(() => {
        parentPort.postMessage('done');
    });
}
