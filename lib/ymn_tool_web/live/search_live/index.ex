defmodule YmnToolWeb.SearchLive.Index do
  use YmnToolWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(q: "")
    |> assign_links("")
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_event("change", %{"q" => q}, socket), do: update_links(socket, q)
  def handle_event("submit", %{"q" => q}, socket), do: update_links(socket, q)

  defp update_links(socket, q) do
    socket
    |> assign(q: q)
    |> assign_links(q)
    |> then(&{:noreply, &1})
  end

  def assign_links(socket, q) do
    [
      set_url("https://qiita.com/search?q=Elixir+", q, "Qiita"),
      set_url("https://www.google.com/search?q=Elixir+", q, "Google"),
      set_url("https://hexdocs.pm/elixir/search.html?q=", q, "hexdocs.pm/elixir"),
      set_url(
        "https://translate.google.com/?hl=ja&tab=wT&sl=en&tl=ja&op=translate&text=",
        q,
        "Google翻訳"
      ),
      set_url("https://www.google.com/search?q=site%3Aelixirschool.com+", q, "elixirschool.com"),
      set_url("https://www.google.com/search?q=site%3Ahexdocs.pm+", q, "hexdocs.pm全体"),
      %{
        url: "https://github.com/search?q=#{q}+language%3AElixir+&type=code",
        text: "github.comコード"
      }
    ]
    |> then(&assign(socket, links: &1))
  end

  def set_url(url, q, text) do
    %{url: "#{url}#{q}", text: text}
  end
end
