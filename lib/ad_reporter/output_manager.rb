# Manage different output
# use like this
# manager = AdReporter::OutputManager.new
# manager.add  AdReporter::Outputs::PrettyStdout.new
module AdReporter
  class OutputManager
    attr_reader :outputs

    def initialize()
      @outputs = []
    end

    # this methods will write data on each outputs defined in this manager
    def process_data(campaigns = [], stats = {})
      @outputs.each do |output|
        output.format_lines(campaigns)
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
  end
end
