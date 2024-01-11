const { parentPort } = require('worker_threads');

function performSimpleOperation() {
    while (true) {
        let _ = 42 * 42;
        setTimeout(() => {
        }, 1000);
    }
}

performSimpleOperation();
