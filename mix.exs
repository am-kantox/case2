defmodule Case2.MixProject do
  use Mix.Project

  @app :case2
  @github "am-kantox/#{@app}"
  @version "0.1.1"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      xref: [exclude: []]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:recase, "~> 0.4", only: :dev, runtime: false},
      {:benchfella, "~> 0.3", only: :dev, runtime: false},
      {:credo, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp description do
    """
    Drop-in replacement for [`Recase`](https://github.com/sobolevn/recase)
    supporting Unicode [Default Identifiers](https://hexdocs.pm/elixir/unicode-syntax.html#r1-default-identifiers).
    """
  end

  defp package do
    [
      name: @app,
      files: ["lib", "config", "mix.exs", "README*"],
      maintainers: ["Aleksei Matiushkin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/#{@github}",
        "Docs" => "http://hexdocs.pm/@{app}"
      }
    ]
  end

  defp docs() do
    [
      # main: "intro",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/#{@app}",
      # logo: "stuff/images/logo.png",
      source_url: "https://github.com/#{@github}",
      # extras: ["stuff/pages/intro.md"],
      groups_for_modules: [
        # Pyc

        # Extras: [
        #   Iteraptor.Iteraptable,
        #   Iteraptor.Extras
        # ],
      ]
    ]
  end
end
