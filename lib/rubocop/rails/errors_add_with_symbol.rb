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
      MSG = 'Only pass symbols to `errors.add`'.freeze

      def_node_matcher :errors_add?, <<-PATTERN
          (send (send _ :errors) :add $...)
      PATTERN

      def_node_matcher :symbolizes?, <<-PATTERN
          (send _ :to_sym)
      PATTERN

      def on_send(node)
        captures = errors_add?(node)
        return unless captures

        message_node = captures[1]

        return if message_node.nil? || message_node.sym_type? || symbolizes?(message_node)

        range = range_between(node.arguments[1].loc.expression.begin_pos,
                              node.arguments[1].loc.expression.end_pos)

        add_offense(node, range, format(MSG))
      end
    end
  end
end
