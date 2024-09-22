defmodule YmnTool.LlmTemplatesTest do
  use ExUnit.Case

  test "load" do
    assert "question,質問" == YmnTool.LlmTemplates.load() |> List.first()
  end
end
