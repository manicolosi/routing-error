require 'faker'
require 'populator'

[User, Question, Answer, Vote].each do |model|
  model.destroy_all
end

20.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.email = Faker::Internet.email
  user.password = 'none'
  user.password_confirmation = 'none'
  user.save!

  Question.populate(1..5) do |question|
    question.author_id = user.id
    question.title = Faker::Lorem.sentence
    question.body = Faker::Lorem.paragraphs.join("\n\n")
  end
end

User.all.each do |user|
  Answer.populate(1..10) do |answer|
    answer.author_id = user.id
    answer.question_id = Question.all.rand.id
    answer.body = Faker::Lorem.paragraphs.join("\n\n")
  end

  Vote.populate(5..25) do |vote|
    vote.voter_id = user.id

    voteable = nil
    loop do
      voteable = [Question, Answer].rand.all.rand
      break if voteable.author_id != user.id
    end

    vote.voteable_id = voteable.id
    vote.voteable_type = voteable.class.to_s

    vote.value = [-1, 1, 1].rand
  end
end
