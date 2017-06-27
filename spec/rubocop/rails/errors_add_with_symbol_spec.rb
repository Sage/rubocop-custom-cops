require 'spec_helper'

RSpec.describe RuboCop::Rails::ErrorsAddWithSymbol do
  subject(:cop) { described_class.new }

  it 'allows errors.add without message' do
    expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:middle_name)
          end
        end
    RUBY
  end

  it 'allows symbols to be passed to errors.add' do
    expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, :too_long)
          end
        end
    RUBY
  end

  it 'allows symbols to be passed to errors.add' do
    expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, :too_long, max: 23)
          end
        end
    RUBY
  end

  it 'allows symbols to be passed to errors.add' do
    expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, 'too_long'.to_sym)
          end
        end
    RUBY
  end

  it 'denies strings to be passed to errors.add' do
    expect_offense(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, 'Das ist eine Übersetzung!')
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Only pass symbols to `errors.add`
          end
        end
    RUBY
  end

  it 'denies strings to be passed to errors.add' do
    expect_offense(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, I18n.t('some.i18n.key'))
                              ^^^^^^^^^^^^^^^^^^^^^^^ Only pass symbols to `errors.add`
          end
        end
    RUBY
  end

  it 'denies strings to be passed to errors.add' do
    expect_offense(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            errors.add(:base, t('some.i18n.key'))
                              ^^^^^^^^^^^^^^^^^^ Only pass symbols to `errors.add`
          end
        end
    RUBY
  end
end
