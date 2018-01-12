require_relative "todo"

class TodoList
  include Hyperloop::Component::Mixin

  state todos: []
  state desc: false

  def add_todo
    if @desc && !@desc.empty?
      mutate.todos << Todo.new(@desc)
      mutate.desc(true)
    end
  end

  def complete_todo(i)
    mutate.todos[i] = state.todos[i].toggle
  end

  def delete_todo(i)
    mutate.todos.delete_at i
  end

  def render
    TABLE(class: "table table-striped table-hover") do
      THEAD do
        TR do
          TH { "#" }
          TH do
            attrs = {
              class: "form-input",
              style: { width: "100%" },
              type: "text"
            }
            if state.desc
              attrs[:value] = ""
              mutate.desc(false)
            end
            INPUT(attrs).on(:input) { |e|
              e.prevent_default
              @desc = e.target.value
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
                checked: todo.status
              ).on(:change) {
                complete_todo i
              }
            end
            TD do
              if todo.status
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
