require "./spec_helper"

class DummyEmmiter
  include Events::Emitter

  emits :dummy, str : String, int : Int32

  def test
    emit_dummy "Foo!", 32
  end
end

describe Events::Emitter do

  it "works" do
    dummy = DummyEmmiter.new

    dummy.on_dummy do |name, bar|
      name.should eq "Foo!"
      bar.should eq 32
    end

    dummy.test
  end
end
