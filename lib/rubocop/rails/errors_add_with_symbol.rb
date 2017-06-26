# frozen_string_literal: true

# Rubocop namespace
module RuboCop
  module Rails
    # This cop enforces usage of ActiveModel::Errors#add with symbols
    #
    # When a symbol is passed to this method, then the I18n lookup happens
    # within the method, allowing to generate error messages in different
    # languages. That's not possible when already translated strings are
    # passed to this method.
    class ErrorsAddWithSymbol < RuboCop::Cop::Cop
    end
  end
end
