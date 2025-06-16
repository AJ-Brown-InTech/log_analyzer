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
    {valids, errors} =

    stream
    |> Stream.map(&String.trim/1)
    |> Enum.reduce({0,0}, fn line, {valid_count, error_count} ->
          if line == "" do
            {valid_count, error_count + 1}
          else
            {valid_count + 1, error_count}
          end
    end)
    IO.puts("Valid count #{valids}")    
    IO.puts("Error count #{errors}")    

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
