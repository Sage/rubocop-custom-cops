require 'spec_helper'

RSpec.describe RuboCop::Rails::ErrorsAddWithSymbol do
  subject(:cop) { described_class.new }

  it 'allows symbols to be passed to errors.add' do
    expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, :too_long)
          end
        end
    RUBY
  end
end
