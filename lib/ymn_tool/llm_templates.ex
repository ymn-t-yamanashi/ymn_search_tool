defmodule YmnTool.LlmTemplates do
  def get(q, question_type \\ "Elixir") do
    """
    #{question_type}で質問。下記を日本語で教えて

    #{q}
    """
  end
end
