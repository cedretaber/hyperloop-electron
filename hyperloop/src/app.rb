require_relative "todo_list"

class Root
  include Hyperloop::Component::Mixin

  render do
    DIV(class: "ink-grid") do
      DIV(class: "column-group") do
        DIV(class: "all-20")
        DIV(class: "all-60") do
          H1 { "Todo List" }
          TodoList()
        end
      end
    end
  end
end
