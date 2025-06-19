defmodule LogAnalyzer do
  
  defp read_file(""), do: {:error, "file path is empty"}
  defp read_file(path) when is_binary(path)  do
     try do
      fstream = File.stream!(path,[],:line)
        IO.puts("Reading file...")
        {:ok, fstream}
     rescue
       e in File.Error -> 
       {:error, e.reason}    
      end
  end

  defp stream_reader(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> stream_counter()
  end

  defp stream_counter(stream) do
    Enum.reduce(stream, {0,0,MapSet.new()}, fn line, {valid_count, error_count, uniques} ->
      cond do
      line == "" ->
        {valid_count, error_count + 1, uniques}
      true ->
        {valid_count + 1, error_count, MapSet.put(uniques, line)}
      end               
    end)
      |> print_results()
  end

defp print_results({valid, error, uniques}) do
  IO.puts("Valid lines: #{valid}")
  IO.puts("Error (empty) lines: #{error}")
  IO.puts("Unique non-empty lines: #{MapSet.size(uniques)}")  
  IO.puts("\n--- Unique Lines ---")
  uniques
    |> Enum.sort()
    |> Enum.each(&IO.puts("- #{&1}"))
end  

  def handle() do
    case read_file("test.txt") do
      {:ok, stream} ->
        stream_reader(stream)
      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}") 
    end
  end
end

LogAnalyzer.handle()
