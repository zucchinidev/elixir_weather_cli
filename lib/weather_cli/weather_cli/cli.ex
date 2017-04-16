defmodule WeatherCli.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions
  that end up generating a table of weather result of a city
  """
  def run(argv) do
    parser_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a city name or city id. Return a tuple of `{ city_id }`,
  or `:help` if help was given.
  """
  def parser_args(argv) do
    parse = OptionParser.parse(argv, switcher: [help: :boolean],
                                     aliases:  [h: :help       ])
    case parse do
      { [help: true], _ } -> :help
      { _ , [ city_id ] } -> { city_id }
      _ -> :help
    end
  end
end