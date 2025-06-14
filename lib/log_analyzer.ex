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
    Enum.each(stream, fn line ->
        IO.puts("line -> #{String.trim(line)}")
    end)
    File.close(stream)  
  end

  # TODO: add metrics 

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
