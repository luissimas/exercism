defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> process(line) end)
    |> Enum.join()
    |> wrap_ul_tags()
  end

  defp process(line) do
    cond do
      String.starts_with?(line, "#") ->
        parse_header(line)

      String.starts_with?(line, "*") ->
        parse_list(line)

      true ->
        line
        |> String.split()
        |> parse_paragraph()
    end
  end

  defp parse_header(hwt) do
    [h | t] = String.split(hwt)

    level = String.length(h)
    text = Enum.join(t, " ")

    "<h#{level}>#{text}</h#{level}>"
  end

  defp parse_list(list) do
    list
    |> String.trim_leading("* ")
    |> String.split()
    |> then(&"<li>#{parse_paragraph_tags(&1)}</li>")
  end

  defp parse_paragraph(text), do: "<p>#{parse_paragraph_tags(text)}</p>"

  defp parse_paragraph_tags(t) do
    t
    |> Enum.map(fn w -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    cond do
      is_strong?(w) -> parse_strong(w)
      is_emph?(w) -> parse_emph(w)
      true -> w
    end
  end

  defp parse_strong(w) do
    w
    |> String.replace(~r/^__/, "<strong>", global: false)
    |> String.replace(~r/__$/, "</strong>")
  end

  defp parse_emph(w) do
    w
    |> String.replace(~r/^_/, "<em>", global: false)
    |> String.replace(~r/_$/, "</em>")
  end

  defp is_strong?(w) do
    String.starts_with?(w, "__") or String.ends_with?(w, "__")
  end

  defp is_emph?(w) do
    String.starts_with?(w, "_") or String.ends_with?(w, "\_")
  end

  defp wrap_ul_tags(list) do
    list
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
