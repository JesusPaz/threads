use tokio::time::{sleep, Duration};

async fn perform_simple_operation() {
    loop {
        let _ = 42 * 42;
        sleep(Duration::from_secs(1)).await;
    }
}

#[tokio::main]
async fn main() {
    let num_tasks = 1;
    let mut tasks = Vec::with_capacity(num_tasks);

    for _ in 0..num_tasks {
        let task = perform_simple_operation();
        tasks.push(tokio::spawn(task));
    }

    for task in tasks {
        task.await.unwrap();
    }
}

