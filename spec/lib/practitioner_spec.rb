require 'rails_helper'

describe Practitioner do
  describe '.safe?' do
    context 'Dirメソッドを使用した場合' do
      it 'falseを返す' do
        command = "Dir.pwd"
        p = Practitioner.new(command)
        expect(p.safe?).to be_falsey
      end
    end
  end
end
