require 'rubocop'
# Rubocop Cop module
module RuboCop
  # Rubocop Lint module
  module Lint
    # SwallowException class for enforcing correct exception handling
    class SwallowedException < RuboCop::Cop::Cop
      # determines whether exceptions are being handled correctly
      def on_resbody(node)
        unless node.children[2]
          add_offense(node, location: :expression, message: 'rescue body is empty!', severity: :fatal)
          return
        end
        body = node.children[2]
        return if raises?(body)
        return if newrelic_captured_exception?(body)
        # rubocop:disable Style/RedundantParentheses
        add_offense(node, location: :expression, message: (<<-MSG).strip, severity: :fatal)
        you have to raise exception or capture exception by NewRelic in rescue body.
        MSG
        # rubocop:enable Style/RedundantParentheses
      end

      private

      def newrelic_captured_exception?(node)
        if node.type == :begin
          node.children.any? { |c| newrelic_captured?(c) }
        else
          newrelic_captured?(node)
        end
      end

      def raises?(node)
        if node.type == :begin
          node.children.any? { |c| raise?(c) }
        else
          raise?(node)
        end
      end

      def newrelic_captured?(node)
        node.type == :send && newrelic?(node.children[0]) && node.children[1] == :notice_error
      end

      def newrelic?(node)
        node && node.type == :const && node.children[0].children[1] == :NewRelic && node.children[1] == :Agent
      end

      def raise?(node)
        node.type == :send &&
          node.children[0].nil? &&
          node.children[1] == :raise
      end
    end
  end
end
