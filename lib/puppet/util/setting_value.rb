module Puppet
module Util

  class SettingValue

    def initialize(setting_value, subsetting_separator = ' ', subsetting_val_separator = '', default_quote_char = nil)
      @setting_value = setting_value
      @subsetting_separator = subsetting_separator

      default_quote_char ||= ''

      if @setting_value
        unquoted, @quote_char = unquote_setting_value(setting_value)
        @subsetting_items = unquoted.scan(Regexp.new("(?:(?:[^\\#{@subsetting_separator}]|\\.)+)"))  # an item can contain escaped separator
        @subsetting_items.map! { |item| item.strip }
        @quote_char = default_quote_char if @quote_char.empty?
      else
        @subsetting_items = []
        @quote_char = default_quote_char
      end     
    end

    def unquote_setting_value(setting_value)
      quote_char = ""
      if (setting_value.start_with?('"') and setting_value.end_with?('"'))
        quote_char = '"'
      elsif (setting_value.start_with?("'") and setting_value.end_with?("'"))
        quote_char = "'"
      end

      unquoted = setting_value

      if (quote_char != "")
        unquoted = setting_value[1, setting_value.length - 2]
      end

      [unquoted, quote_char]
    end

    def get_value
    
      result = ""
      first = true
      
      @subsetting_items.each { |item|
        result << @subsetting_separator unless first
        result << item        
        first = false
      }
      
      @quote_char + result + @quote_char
    end

    def get_subsetting_value(subsetting, val_separator)
    
      value = nil
      
      @subsetting_items.each { |item|
        subsetting_and_val_separator = subsetting+val_separator
        if(item.start_with?(subsetting_and_val_separator))
          value = item[subsetting_and_val_separator.length, item.length - subsetting_and_val_separator.length]
          break
        end
      }
      
      value
    end
    
    def add_subsetting(subsetting, val_separator, subsetting_value)
    
      new_item = subsetting + (val_separator || '') + (subsetting_value || '')
      found = false

      @subsetting_items.map! { |item|
        if item.start_with?(subsetting+val_separator)
          value = new_item
          found = true
        else
          value = item
        end
        
        value
      }
      
      unless found
        @subsetting_items.push(new_item)
      end
    end

    def remove_subsetting(subsetting, val_separator)   
      @subsetting_items = @subsetting_items.map { |item| item.start_with?(subsetting+val_separator) ? nil : item }.compact
    end
    
  end
end
end
