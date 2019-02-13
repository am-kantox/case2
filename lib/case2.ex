defmodule Case2 do
  @moduledoc """
  `Case2` is a handy utility to transform case of strings.
  """

  @delimiters Application.get_env(:case2, :delimiters, [?\s, ?\n, ?-, ?_, ?.])

  @doc """
  Converts the input to **`camel`** case.

  ## Examples

      iex> Case2.to_camel "foo_barBaz-λambdaΛambda-привет-Мир"
      "fooBarBazΛambdaΛambdaПриветМир"

  Read about `camelCase` here: https://en.wikipedia.org/wiki/Camel_case
  """
  @spec to_camel(input :: String.t()) :: String.t()
  def to_camel(input) when is_binary(input) do
    result =
      input
      |> do_split()
      |> Enum.map(fn <<char::utf8, rest::binary>> -> String.upcase(<<char::utf8>>) <> rest end)
      |> Enum.join()

    with <<char::utf8, rest::binary>> <- result,
         do: String.downcase(<<char::utf8>>) <> rest
  end

  @doc """
  Converts the input to **`pascal`** case.

  ## Examples

      iex> Case2.to_pascal "foo_barBaz-λambdaΛambda-привет-Мир"
      "FooBarBazΛambdaΛambdaПриветМир"
  """
  @spec to_pascal(input :: String.t()) :: String.t()
  def to_pascal(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.map(fn <<char::utf8, rest::binary>> -> String.upcase(<<char::utf8>>) <> rest end)
    |> Enum.join()
  end

  @doc """
  Converts the input to **`snake`** case. Alias: **`underscore`**.

  ## Examples

      iex> Case2.to_snake "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo_bar_baz_λambda_λambda_привет_мир"
      iex> Case2.underscore "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo_bar_baz_λambda_λambda_привет_мир"
  """
  @spec to_snake(input :: String.t()) :: String.t()
  def to_snake(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.map(fn <<char::utf8, rest::binary>> -> String.downcase(<<char::utf8>>) <> rest end)
    |> Enum.join("_")
  end

  defdelegate underscore(input), to: Case2, as: :to_snake

  @doc """
  Converts the input to **`kebab`** case.

  ## Examples

      iex> Case2.to_kebab "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo-bar-baz-λambda-λambda-привет-мир"
  """
  @spec to_kebab(input :: String.t()) :: String.t()
  def to_kebab(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.map(fn <<char::utf8, rest::binary>> -> String.downcase(<<char::utf8>>) <> rest end)
    |> Enum.join("-")
  end

  @doc """
  Converts the input to **`constant`** case.

  ## Examples

      iex> Case2.to_constant "foo_barBaz-λambdaΛambda-привет-Мир"
      "FOO_BAR_BAZ_ΛAMBDA_ΛAMBDA_ПРИВЕТ_МИР"
  """
  @spec to_constant(input :: String.t()) :: String.t()
  def to_constant(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.join("_")
    |> String.upcase()
  end

  @doc """
  Converts the input to **`path`** case.

  ## Examples

      iex> Case2.to_path "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo/bar/Baz/λambda/Λambda/привет/Мир"
  """
  @spec to_path(input :: String.t()) :: String.t()
  def to_path(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.join("/")
  end

  @doc """
  Converts the input to **`dot`** case.

  ## Examples

      iex> Case2.to_dot "foo_barBaz-λambdaΛambda-привет-Мир"
      "foo.bar.baz.λambda.λambda.привет.мир"
  """
  @spec to_dot(input :: String.t()) :: String.t()
  def to_dot(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.map(fn <<char::utf8, rest::binary>> -> String.downcase(<<char::utf8>>) <> rest end)
    |> Enum.join(".")
  end

  @doc """
  Converts the input to **`sentence`** case.

  Read about `Sentence case` here:
    https://en.wikipedia.org/wiki/Letter_case#Sentence_case


  ## Examples

      iex> Case2.to_sentence "foo_barBaz-λambdaΛambda-привет-Мир"
      "Foo bar baz λambda λambda привет мир"
  """
  @spec to_sentence(input :: String.t()) :: String.t()
  def to_sentence(input) when is_binary(input) do
    result =
      input
      |> do_split()
      |> Enum.map(fn <<char::utf8, rest::binary>> -> String.downcase(<<char::utf8>>) <> rest end)
      |> Enum.join(" ")

    with <<char::utf8, rest::binary>> <- result,
         do: String.upcase(<<char::utf8>>) <> rest
  end

  @doc """
  Converts the input to **`title`** case.

  Read about `Sentence case` here:
    https://en.wikipedia.org/wiki/Letter_case#Title_case

  **NB!** at the moment has no stop words: titleizes everything

  ## Examples

      iex> Case2.to_title "foo_barBaz-λambdaΛambda-привет-Мир"
      "Foo Bar Baz Λambda Λambda Привет Мир"
  """
  @spec to_title(input :: String.t()) :: String.t()
  def to_title(input) when is_binary(input) do
    input
    |> do_split()
    |> Enum.map(fn <<char::utf8, rest::binary>> -> String.upcase(<<char::utf8>>) <> rest end)
    |> Enum.join(" ")
  end

  @doc """
  Splits the input into **`list`**. Utility function.

  ## Examples

      iex> Case2.split "foo_barBaz-λambdaΛambda-привет-Мир"
      ["foo", "bar", "Baz", "λambda", "Λambda", "привет", "Мир"]
  """
  @spec split(input :: String.t()) :: [String.t()]
  def split(input) when is_binary(input), do: do_split(input)

  ##############################################################################

  @spec do_split(input :: String.t(), acc :: [String.t()]) :: [String.t()]
  defp do_split(string, acc \\ {"", []})

  defp do_split("", {"", acc}), do: Enum.reverse(acc)

  defp do_split("", {curr, acc}),
    do: do_split("", {"", [curr | acc]})

  Enum.each(@delimiters, fn delim ->
    defp do_split(<<unquote(delim)::utf8, rest::binary>>, {"", acc}),
      do: do_split(rest, {"", acc})

    defp do_split(<<unquote(delim), rest::binary>>, {curr, acc}),
      do: do_split(rest, {"", [curr | acc]})
  end)

  Enum.each(?A..?Z, fn char ->
    defp do_split(<<unquote(char), rest::binary>>, {"", acc}),
      do: do_split(rest, {<<unquote(char)::utf8>>, acc})

    defp do_split(<<unquote(char), rest::binary>>, {curr, acc}),
      do: do_split(rest, {<<unquote(char)::utf8>>, [curr | acc]})
  end)

  [32..64, 91..127]
  |> Enum.map(&Enum.to_list/1)
  |> Enum.reduce(&Kernel.++/2)
  |> Kernel.--(@delimiters)
  |> Enum.each(fn char ->
    defp do_split(<<unquote(char)::utf8, rest::binary>>, {"", acc}),
      do: do_split(rest, {<<unquote(char)::utf8>>, acc})

    defp do_split(<<unquote(char), rest::binary>>, {curr, acc}),
      do: do_split(rest, {curr <> <<unquote(char)::utf8>>, acc})
  end)

  defp do_split(<<char::utf8, rest::binary>>, {"", acc}),
    do: do_split(rest, {<<char::utf8>>, acc})

  @upcase ~r/\p{Lu}/u

  defp do_split(<<char::utf8, rest::binary>>, {curr, acc}) do
    if Regex.match?(@upcase, <<char::utf8>>) do
      do_split(rest, {<<char::utf8>>, [curr | acc]})
    else
      do_split(rest, {curr <> <<char::utf8>>, acc})
    end
  end
end
