defmodule YmnTool.LlmTemplates do
  def get(q) do
    """
    Elixirで質問。下記を日本語で教えて

    #{q}
    """
  end
end
