import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class Threads {

    public static void performSimpleOperation() {
        while (true) {
            int result = 42 * 42;
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) throws InterruptedException, ExecutionException {
        int numThreads = 1000000;
        List<Future<?>> futures = new ArrayList<>();

        ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor();

        for (int i = 0; i < numThreads; i++) {
            Future<?> future = executor.submit(VirtualThreads::performSimpleOperation);
            futures.add(future);
        }

        for (Future<?> future : futures) {
            future.get();
        }

        executor.shutdown();
    }
}
