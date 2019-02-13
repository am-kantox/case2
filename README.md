# Case2

**Drop-in replacement for [`Recase`](https://github.com/sobolevn/recase) supporting Unicode [Default Identifiers](https://hexdocs.pm/elixir/unicode-syntax.html#r1-default-identifiers).**

## Use cases

```elixir
iex> Case2.to_snake "foo_barBaz-λambdaΛambda-привет-Мир"
#⇒ "foo_bar_baz_λambda_λambda_привет_мир"
iex> Case2.underscore "foo_barBaz-λambdaΛambda-привет-Мир"
#⇒ "foo_bar_baz_λambda_λambda_привет_мир"
```

For more use-cases check the documentation for [`Case2`](https://hexdocs.pm/case2/Case2.html) module.

## Installation

```elixir
def deps do
  [
    {:case2, "~> 0.1"}
  ]
end
```

## BasicBench

The execution time is comparable with ASCII-only `Recase` functions due to
smart pattern-matching whenever possible.

```
benchmark name        iterations   average time
Recase.to_path/1           20000   85.41 µs/op
Recase.to_pascal/1         10000   126.80 µs/op
Recase.to_camel/1          10000   126.85 µs/op
Case2.to_path/1            10000   198.51 µs/op
Case2.to_constant/1        10000   206.11 µs/op
Case2.to_pascal/1          10000   225.29 µs/op
Case2.to_title/1           10000   226.83 µs/op
Case2.to_camel/1           10000   227.41 µs/op
Recase.to_snake/1          10000   236.61 µs/op
Case2.to_snake/1           10000   241.41 µs/op
Case2.to_sentence/1        10000   241.75 µs/op
Case2.to_kebab/1           10000   242.71 µs/op
Recase.to_constant/1       10000   246.04 µs/op
Recase.to_kebab/1          10000   248.39 µs/op
Recase.to_sentence/1       10000   248.42 µs/op
Recase.to_dot/1            10000   248.61 µs/op
Case2.to_dot/1             10000   249.84 µs/op
```

## Documentation [https://hexdocs.pm/case2](https://hexdocs.pm/case2).

