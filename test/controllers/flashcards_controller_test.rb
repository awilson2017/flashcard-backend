require 'test_helper'

class FlashcardsControllerTest < ActionDispatch::IntegrationTest
  let(:flashcard) { flashcards :one }

  it "gets index" do
    get flashcards_url
    value(response).must_be :success?
  end

  it "creates flashcard" do
    expect {
      post flashcards_url, params: { flashcard: { korean_word: flashcard.korean_word, user_id: flashcard.user_id } }
    }.must_change "Flashcard.count"

    value(response.status).must_equal 201
  end

  it "shows flashcard" do
    get flashcard_url(flashcard)
    value(response).must_be :success?
  end

  it "updates flashcard" do
    patch flashcard_url(flashcard), params: { flashcard: { korean_word: flashcard.korean_word, user_id: flashcard.user_id } }
    value(response.status).must_equal 200
  end

  it "destroys flashcard" do
    expect {
      delete flashcard_url(flashcard)
    }.must_change "Flashcard.count", -1

    value(response.status).must_equal 204
  end
end
