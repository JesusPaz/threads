import threading
import time


def perform_simple_operation():
    while True:
        _ = 42 * 42
        time.sleep(1)


def main():
    num_threads = 1000000
    threads = []

    for i in range(num_threads):
        thread = threading.Thread(target=perform_simple_operation)
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


if __name__ == "__main__":
    main()
