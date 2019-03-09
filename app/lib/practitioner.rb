class Practitioner
  attr_reader :command
  def initialize(command)
    @command = command
    @result = "/ruby_exec " + command + "\n"
  end
  def execute
    @result << eval(command).to_s
  end
end
