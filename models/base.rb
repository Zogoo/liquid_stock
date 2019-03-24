module Models
  class Base
    def define_from_column_names(column_names)
      column_names.each do |field|
        snake_field = to_snakecase(field)
        define_singleton_method(snake_field) do
          instance_variable_get("@#{snake_field}")
        end
        define_singleton_method("#{snake_field}=") do |value|
          instance_variable_set("@#{snake_field}", value)
        end
      end
    end

    def to_snakecase(field)
      field.split(/\.|\-|\ /).reject(&:empty?).join.snakecase
    end
  end
end
