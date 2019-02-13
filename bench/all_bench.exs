defmodule BasicBench do
  use Benchfella

  @string """
  foo_barBaz-λambdaΛambda-привет-Мирfoo_barBaz-λambdaΛambda-привет-Мир
  foo_barBaz-λambdaΛambda-привет-Мирfoo_barBaz-λambdaΛambda-привет-Мир
  foo_barBaz-λambdaΛambda-привет-Мирfoo_barBaz-λambdaΛambda-привет-Мир
  """
  @functions ~w|to_camel to_constant to_dot to_kebab to_pascal
                to_path to_sentence to_snake to_title|a

  Enum.each(@functions, fn fun ->
    @fun fun
    bench("Case2.#{@fun}/1", do: apply(Case2, @fun, [@string]))

    if Recase.__info__(:functions)[@fun] == 1,
      do: bench("Recase.#{@fun}/1", do: apply(Recase, @fun, [@string]))
  end)
end
