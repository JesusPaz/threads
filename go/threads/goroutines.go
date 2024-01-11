package main

import (
	"time"
)

func performSimpleOperation() {
	for {
		_ = 42 * 42
		time.Sleep(1 * time.Second)
	}
}

func main() {
	numGoroutines := 1000000

	for i := 0; i < numGoroutines; i++ {
		go performSimpleOperation()
	}

	select {}
}
