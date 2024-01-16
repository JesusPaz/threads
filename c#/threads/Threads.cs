using System;
using System.Threading;
using System.Collections.Generic;

class Threads
{
    static void PerformSimpleOperation()
    {
        while (true)
        {
            var result = 42 * 42;
            Thread.Sleep(1000); // 1000 milliseconds = 1 second
        }
    }

    static void Main(string[] args)
    {
        int numThreads = 1;
        List<Thread> threads = new List<Thread>();

        for (int i = 0; i < numThreads; i++)
        {
            Thread thread = new Thread(PerformSimpleOperation);
            thread.Start();
            threads.Add(thread);
        }

        foreach (Thread thread in threads)
        {
            thread.Join();
        }
    }
}
