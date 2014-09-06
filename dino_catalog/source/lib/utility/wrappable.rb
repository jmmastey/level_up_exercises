# OPT #1 (BAD) - METHOD_MISSING, CHECK IF WRAPPED, SUPER IF NOT

module Utility
  module Wrappable
    def self.included(base)
      base.instance_eval %{
        @wrappables ||= {}
        attr_accessor :wrappables
      }
      base.extend(Core)
    end
    module Hook
    end
    module Core
      def attr_wrappable(method, &block)
        prepend build_wrappable_module(method, &block)
      end

      private

      def build_wrappable_module(method_name, &block)
        hook = Hook.clone
        hook.class_exec(block) do |b|
          define_method(:bar, &b)
        end
        hook
      end
    end
  end
  class Foo
    include Utility::Wrappable

    attr_wrappable :bar do |*args|
      "!FOOBAR#{super(*args)}FUBAR!"
    end

    attr_reader :test
    def initialize; @test = foo; end
    def foo; "FOO#{before}"; end
    def before; "BEFORE#{bar('SOMETHING')}#{finish}"; end
    def bar(thing); "!#{thing}!"; end
    def finish; "DONE"; end
  end
end

puts "TEST:     FOOBEFORE!FOOBAR!SOMETHING!FUBAR!DONE"
puts "RESPONSE: #{Utility::Foo.new.test}"