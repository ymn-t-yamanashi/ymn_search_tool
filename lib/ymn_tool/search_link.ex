defmodule YmnTool.SearchLink do
  def get(q, question_type \\ "Elixir") do
    [
      set_url("https://hexdocs.pm/elixir/search.html?q=", q, "hexdocs.pm/elixir"),
      set_url("https://www.google.com/search?q=site%3Ahexdocs.pm+", q, "hexdocs.pm全体"),
      set_url("https://qiita.com/search?q=#{question_type}+", q, "Qiita"),
      set_url("https://www.google.com/search?q=#{question_type}+", q, "Google"),
      set_url(
        "https://translate.google.com/?hl=ja&tab=wT&sl=en&tl=ja&op=translate&text=",
        q,
        "Google翻訳"
      ),
      set_url("https://ja.wikipedia.org/wiki/", q, "wiki"),
      set_url("https://www.google.com/search?q=site%3Aelixirschool.com+", q, "elixirschool.com"),
      %{
        url: "https://github.com/search?q=#{q}+language%3AElixir+&type=code",
        text: "github.com Elixirコード"
      }
    ]
  end

  defp set_url(url, q, text) do
    %{url: "#{url}#{q}", text: text}
  end
end
