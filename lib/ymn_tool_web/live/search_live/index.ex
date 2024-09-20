defmodule YmnToolWeb.SearchLive.Index do
  use YmnToolWeb, :live_view
  alias YmnTool.SearchLink

  @impl true
  def mount(params, _session, socket) do
    IO.inspect(params)

    q = Map.get(params, "q", "")

    socket
    |> assign(q: q)
    |> assign_links(q)
    |> assign_prompt(q)
    |> then(&{:ok, &1})
  end

  @impl true
  def handle_event("change", %{"q" => q}, socket), do: update_links(socket, q)
  def handle_event("submit", %{"q" => q}, socket), do: update_links(socket, q)
  def handle_event("clear-click", _, socket), do: update_links(socket, "")

  defp update_links(socket, q) do
    socket
    |> assign(q: q)
    |> assign_links(q)
    |> assign_prompt(q)
    |> then(&{:noreply, &1})
  end

  defp assign_links(socket, q) do
    SearchLink.get(q)
    |> then(&assign(socket, links: &1))
  end

  defp assign_prompt(socket, q) do
    """
    Elixirで質問。下記を日本語で教えて

    #{q}
    """
    |> then(&assign(socket, prompt: &1))
  end
end
