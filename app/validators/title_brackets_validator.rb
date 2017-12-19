class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie)
    unless matching_brackets?(movie.title)
      movie.errors.add :base, 'This record is invalid'
    end
  end

  private

  def matching_brackets?(title)
    brackets =  {'[' => ']', '{' => '}', '(' => ')'}
    lefts = brackets.keys
    rights = brackets.values
    stack = []
    title.each_char.with_index do |c, i|
      if lefts.include? c
        stack.push c
      elsif rights.include? c
        return false if title[i-1].eql? brackets.invert[c]
        return false if stack.empty?
        return false unless brackets[stack.pop].eql? c
      end
    end
    stack.empty?
  end

end