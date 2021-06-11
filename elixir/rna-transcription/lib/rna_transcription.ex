defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    # Map containing the conversions
    nucleotides = %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}

    # Maping the list and getting the corresponding complement
    Enum.map(dna, fn x -> nucleotides[x] end)
  end
end
