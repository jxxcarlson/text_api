defmodule TextApi.Utility do

  def project2map(input) do
    if is_binary(input) do
      {:ok, decoded} = Poison.Parser.parse input
      decoded
    else
      input
    end
  end
  
end
