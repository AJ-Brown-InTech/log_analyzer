defmodule LogAnalyzer do
  @moduledoc """
  Documentation for `LogAnalyzer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LogAnalyzer.hello()
      Hello World

  """
  def hello do
     IO.puts("Hello World")
  end

  @doc """
  open_file
      - accepts a file path as a string
    ## Examples
     iex> LogAnalyzer.open_file("")
     {:error, "file path is empty"} 
        
     iex> LogAnalyzer.open_file("example.txt")
     {:ok, :contents...}
  """
  def open_file(""), do: {:error, "file path is empty"}

  def open_file(path) do
    File.read(path)
  end

end


LogAnalyzer.hello()
