package main

import (
	"time"
)

func performSimpleOperation(done chan<- bool) {
	for {
		_ = 42 * 42
		time.Sleep(1 * time.Second)
	}
}

func main() {
	numGoroutines := 1000000

	done := make(chan bool)
	for i := 0; i < numGoroutines; i++ {
		go performSimpleOperation(done)
	}

	for i := 0; i < numGoroutines; i++ {
		<-done
	}
}
