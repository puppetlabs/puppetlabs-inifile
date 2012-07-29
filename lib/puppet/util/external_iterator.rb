module Puppet
module Util
  class ExternalIterator
    def initialize(coll)
      @coll = coll
      @cur_index = 0
    end

    def next
      @cur_index = @cur_index + 1
      item_at(@cur_index)
    end

    def peek
      item_at(@cur_index + 1)
    end

    private
    def item_at(index)
      [@coll[index], index]
    end
  end
end
end
