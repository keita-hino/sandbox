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

    context 'Fileメソッドを使用した場合' do
      it 'falseを返す' do
        command = "File.join"
        p = Practitioner.new(command)
        expect(p.safe?).to be_falsey
      end
    end

    context 'IOメソッドを使用した場合' do
      it 'falseを返す' do
        command = "IO.pipe"
        p = Practitioner.new(command)
        expect(p.safe?).to be_falsey
      end
    end

    context 'FileTestメソッドを使用した場合' do
      it 'falseを返す' do
        command = "FileTest.methods(false)"
        p = Practitioner.new(command)
        expect(p.safe?).to be_falsey
      end
    end

    context 'ENVを参照しようとした場合' do
      it 'falseを返す' do
        command = "ENV"
        p = Practitioner.new(command)
        expect(p.safe?).to be_falsey
      end
    end
  end
  
  describe 'escape!' do
    context '文字列を含む時' do
      it 'エスケープした値を返す' do
        command = "”a“"
        p = Practitioner.new(command).escape!
        expect(p).to eq("'a'")
      end
    end
  end
end
