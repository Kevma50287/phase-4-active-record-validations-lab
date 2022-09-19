class Post < ApplicationRecord
    validates_presence_of :title
    validates :content, length: {minimum:250}
    validates :summary, length: {maximum:250}
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validate :clickbait?

    # REGEX expressions
    # /word/ will return the index of the first occruence of word that is found in the string. If not found returns nil
    # \d is [0-9], \s is for whitespace, \w is for non-special characters [0-9a-zA-Z_]
    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
      ]
    

      def clickbait?
        # .none? returns true if each item in the array (the one calling the .none? method) does not fulfill 
        # the condition in the block
        # the condition in the block below uses .match to compare each REGEX string to the title
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
          errors.add(:title, "must be clickbait")
        end
      end
end
