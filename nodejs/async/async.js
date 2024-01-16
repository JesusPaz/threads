async function performSimpleOperation() {
    while (true) {
        let _ = 42 * 42;
        await new Promise(resolve => setTimeout(resolve, 1000));
    }
}

function main() {
    const numTasks = 1;

    for (let i = 0; i < numTasks; i++) {
        performSimpleOperation();
    }

}

main();
