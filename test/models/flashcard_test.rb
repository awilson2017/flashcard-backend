require "test_helper"

describe Flashcard do
  let(:flashcard) { Flashcard.new }

  it "must be valid" do
    value(flashcard).must_be :valid?
  end
end
