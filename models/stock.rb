module Models
  class Stock < Base
    def value_from_array(column_names, values)
      column_names.each_with_index do |name, index|
        send "#{to_snakecase(name)}=", values[index]
      end
    end

    def self.load_from_dataset(dataset)
      column_names = dataset['dataset']['column_names']
      dataset['dataset']['data'].map do |d|
        stock = new
        stock.define_from_column_names(column_names)
        stock.value_from_array(column_names, d)
        stock
      end
    end
  end
end
