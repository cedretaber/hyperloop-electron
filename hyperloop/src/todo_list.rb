require_relative "todo"

class TodoList
  include Hyperloop::Component::Mixin

  state todos: []
  state desc: ""

  def add_todo
    mutate.todos << Todo.new(state.desc, false)
    mutate.desc("")
  end

  def complete_todo(i)
    mutate.todos(state.todos.tap { |todos|
      todos[i] = todos[i].toggle
    })
  end

  def delete_todo(i)
    mutate.todos(state.todos.tap { |todos|
      todos.delete_at i
    })
  end

  render do
    TABLE(class: "ink-table") do
      THEAD do
        TR do
          TH { "#" }
          TH { "description" }
          TH { "completed" }
          TH {}
        end
      end
      TBODY do
        TR do
          TD {}
          TD(colSpan: "2") do
            INPUT(
              style: { width: "100%" },
              type: "text",
              value: state.desc
            ).on(:input) { |e|
              e.prevent_default
              mutate.desc(e.target.value)
            }
          end
          TD do
            BUTTON { ">>" }.on(:click) { add_todo }
          end
        end
        state.todos.each.with_index do |todo, i|
          TR do
            TD { (i+1).to_s }
            TD { todo.desc }
            TD do
              INPUT(type: :checkbox, value: todo.status).on(:change) {
                complete_todo i
              }
            end
            TD do
              BUTTON { "×" }.on(:click) { delete_todo i }
            end
          end
        end
      end
    end
  end
end
