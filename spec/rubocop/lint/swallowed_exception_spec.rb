require 'spec_helper'

RSpec.describe RuboCop::Lint::SwallowedException do
  subject(:cop) { described_class.new }

  context 'when NewRelic reports the error' do
    it 'expects no offense is reported' do
      expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            begin

            rescue
              NewRelic::Agent.notice_error('message')
            end
          end
        end
      RUBY
    end
  end

  context 'when other actions are performed as well as NewRelic Report' do
    it 'expects no offense is reported' do
      expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            begin

            rescue
              Rails.logger.error('message')
              NewRelic::Agent.notice_error('message')
            end
          end
        end
      RUBY
    end
  end

  context 'when an exception is re raised' do
    it 'expects no offense reported' do
      expect_no_offenses(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            begin

            rescue => e
              raise e
            end
          end
        end
      RUBY
    end
  end

  context 'when the exception is swallowed' do
    context 'when NewRelic does not report the exception' do
      it 'expects an offense' do
        expect_offense(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            begin

            rescue
            ^^^^^^ rescue body is empty!
            end
          end
        end
        RUBY
      end
    end
  end

  context 'when no appropriate action is taken in the rescue block' do
    it 'expects an offense' do
      expect_offense(<<-RUBY.strip_indent)
        class Person < ActiveRecord::Base
          def my_validation
            begin

            rescue
            ^^^^^^ you have to raise exception or capture exception by NewRelic in rescue body.
            Rails.logger.error('message')
            end
          end
        end
      RUBY
    end
  end
end
