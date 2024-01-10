const { Worker, isMainThread, parentPort } = require('worker_threads');

function performSimpleOperation() {
    // A very simple operation
    return 42 * 42;
}

if (isMainThread) {
    // Este es el hilo principal
    const numWorkers = 1000000;  // Número de Workers a crear
    for (let i = 0; i < numWorkers; i++) {
        new Worker(__filename);
    }
} else {
    // Este es un Worker
    setInterval(() => {
        performSimpleOperation();
    }, 1000); // Ejecutar cada 1 segundo
}
