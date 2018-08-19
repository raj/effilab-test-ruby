module AdReporter
  class OutputManager
    attr_reader :outputs

    def initialize()
      @outputs = []
    end

    def process_data(campaigns = [], stats = {})
      @outputs.each do |output|
        output.format(campaigns)
        output.format_footer(stats)
        output.flush
      end
    end

    # The 'add' method adds a child component
    # to the current component class.
    def add(output)
      @outputs.push(output)
      output.parent = self
    end

    # The 'remove' method removes a child
    # component from the current component
    # class.
    def remove(output)
      @outputs.delete(output)
      output.parent = nil
    end

    # The 'get_output' method will return a
    # output component of this class by index.
    def get_output(index)
      @outputs[index]
    end

    # The 'get_outputs' method will return
    # an array of the output of the current
    # component.
    def get_outputs
      @outputs
    end
  end
end
