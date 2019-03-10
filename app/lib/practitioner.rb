class Practitioner
  attr_reader :command
  def initialize(command)
    @command = command
    @result = "/ruby_exec " + command + "\n"
  end

  def execute
    if safe?
      begin
        @result << eval(command).to_s
      rescue => e
        @result << e.to_s
      end
    else
      @result << "許可されていない処理が含まれています。"
    end
  end

  def safe?
    l = ["Dir.","File.","IO.","FileTest","ENV"]
    l.map do |v|
      return false if command.include?(v)
    end
    return true
  end
end
