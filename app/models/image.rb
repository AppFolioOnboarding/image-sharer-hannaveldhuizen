class Image < ApplicationRecord
  valid = %r/\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix

  validates :url, presence: true, format: {
    with: valid,
    message: 'You must input a valid URL.'
  }
end
