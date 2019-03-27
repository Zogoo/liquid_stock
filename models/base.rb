module Models
  # Quandl API base model
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

    # Quandl response column_name convert to instance variable name
    # Quandl API column_names seperator are
    # dot(.) hyphens (-) and space.
    def to_snakecase(field)
      field.split(/\.|\-|\ /).reject(&:empty?).join.snakecase
    end
  end
end
