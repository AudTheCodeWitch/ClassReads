Teacher.all.each do |t|
  # create book library
  50.times do
    b = Faker::Book
    Book.create(title: b.title, author: b.author, genre: b.genre, teacher_id: t.id)
  end

  # create students
  20.times do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    name = "#{first} #{last}"
    username = first[0] + last
    pass = Faker::Creature::Animal
    Student.create(name: name, username: username.downcase, password: pass.name, teacher_id: t.id)
  end
end

# Create book reviews
Student.all.each do |s|
  5.times do
    rating = Faker::Number.within(range: 1..5)
    review = Faker::Movies::HarryPotter.quote
    t = Teacher.find_by(id: s.teacher_id)
    book = t.books[rand(t.books.length)]
    Review.create(rating: rating, review: review, student_id: s.id, book_id: book.id)
  end
end
