require_relative "todo_list"

class Root
  include Hyperloop::Component::Mixin

  def render
    DIV(class: "container") do
      DIV(class: "columns") do
        DIV(class: "column col-8 col-mx-auto") do
          H1 { "Todo List" }
          TodoList()
        end
      end
    end
  end
end
