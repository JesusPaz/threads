package main

import (
	"sync"
	"time"
)

func main() {
	var wg sync.WaitGroup
	numGoroutines := 1000000         // Number of goroutines to create
	sleepDuration := 1 * time.Second // Duration to sleep after each operation

	for i := 0; i < numGoroutines; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()

			for {
				performSimpleOperation()
				time.Sleep(sleepDuration) // Sleep for 1 second after the operation
			}
		}()
	}
	wg.Wait()
}

func performSimpleOperation() {
	// A very simple operation
	_ = 42 * 42
}
