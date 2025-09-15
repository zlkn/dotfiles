// Go — syntax sampler
package main

import (
	"context"
	"errors"
	"fmt"
	"math"
	"time"
)

const (
	_        = iota
	Small    = 1 << (10 * iota)
	Medium
	Large
)

type Number interface{ ~int | ~float64 }

type Pair[T any] struct {
	A T
	B T
}

type Stringer interface{ String() string }

func (p Pair[T]) Swap() Pair[T] { return Pair[T]{p.B, p.A} }

func Sum[T Number](xs []T) T {
	var s T
	for _, v := range xs {
		s += v
	}
	return s
}

func work(ctx context.Context, in chan int) (map[string]float64, error) {
	out := make(map[string]float64)
	select {
	case v := <-in:
		out["sqrt"] = math.Sqrt(float64(v))
	case <-ctx.Done():
		return nil, errors.New("timeout")
	}
	return out, nil
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), 50*time.Millisecond)
	defer cancel()

	ch := make(chan int, 1)
	go func() { ch <- 42 }()

	res, err := work(ctx, ch)
	if err != nil {
		fmt.Printf("err: %v\n", err)
		return
	}
	fmt.Printf("sum=%v swap=%+v res=%v\n", Sum([]int{1, 2, 3}), Pair[int]{1, 2}.Swap(), res)
}
