import threading
import time


def perform_simple_operation():
    # A very simple operation
    _ = 42 * 42


def thread_function():
    while True:
        perform_simple_operation()
        time.sleep(1)  # Sleep for 1 second after the operation


def main():
    num_threads = 1000000  # Number of threads to create
    threads = []

    for _ in range(num_threads):
        t = threading.Thread(target=thread_function)
        t.start()
        threads.append(t)

    for t in threads:
        t.join()


if __name__ == "__main__":
    main()
