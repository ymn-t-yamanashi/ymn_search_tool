defmodule YmnTool.LlmTemplatesTest do
  use ExUnit.Case

  test "load" do
    assert 3 == YmnTool.LlmTemplates.load()
  end
end
