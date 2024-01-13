using System;
using System.Threading.Tasks;
using System.Collections.Generic;

class Program
{
    static async Task PerformSimpleOperation()
    {
        while (true)
        {
            var result = 42 * 42;
            await Task.Delay(1000); 
        }
    }

    static async Task Main(string[] args)
    {
        int numTasks = 1000000;
        List<Task> tasks = new List<Task>();

        for (int i = 0; i < numTasks; i++)
        {
            tasks.Add(PerformSimpleOperation());
        }

        await Task.WhenAll(tasks);
    }
}
