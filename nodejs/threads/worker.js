const { parentPort } = require('worker_threads');

async function performSimpleOperation() {
    while (true) {
        let _ = 42 * 42;
        await new Promise(resolve => setTimeout(resolve, 1000));
    }
}

performSimpleOperation().then(() => {
    parentPort.postMessage('done');
});
