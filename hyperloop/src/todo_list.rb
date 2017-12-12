require_relative "todo"

class TodoList
  include Hyperloop::Component::Mixin

  state todos: []
  state desc: ""

  def add_todo
    mutate.todos << Todo.new(state.desc)
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

  def render
    TABLE(class: "table table-striped table-hover") do
      THEAD do
        TR do
          TH { "#" }
          TH do
            INPUT(
              class: "form-input",
              style: { width: "100%" },
              type: "text",
              value: state.desc
            ).on(:input) { |e|
              e.prevent_default
              mutate.desc(e.target.value)
            }
          end
          TH do
            BUTTON(class: "btn") { ">>" }.on(:click) { add_todo }
          end
        end
      end
      TBODY do
        state.todos.each.with_index do |todo, i|
          TR do
            TD do
              SPAN { "#{(i+1).to_s} / " }
              INPUT(
                class: "form-checkbox",
                type: :checkbox,
                value: todo.status
              ).on(:change) {
                complete_todo i
              }
            end
            TD do
              if state.todos[i].status
                DEL { todo.desc }
              else
                todo.desc
              end
            end
            TD do
              BUTTON(class: "btn") { "×" }.on(:click) { delete_todo i }
            end
          end
        end
      end
    end
  end
end
