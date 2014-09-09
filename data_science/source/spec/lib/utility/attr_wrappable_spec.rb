# rubocop:disable all
require_relative '../../spec_helper.rb'
require_relative '../../../lib/utility/attr_wrappable.rb'

module Utility
  module Mocks
    class Foo
      include ::Utility::Wrappable

      attr_wrappable :foo do |*args|
        "#{super(*args)}"
      end

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

  describe Wrappable do
    context 'after included' do
      it 'will expose attr_wrappable' do
        expect(Mocks::Foo.methods).to include(:attr_wrappable)
      end
      context 'attr_wrappable' do
        foo = Mocks::Foo.new
        it 'will expose the wrappables' do
          expect(foo.public_methods).to include(:wrappables)
        end
        it 'will record wrapped methods in @wrappables' do
          wrappables = foo.wrappables
          expect(wrappables.keys).to include(:foo, :bar)
        end
        it 'will wrap a method' do
          fail
        end
        it 'will follow the defined chain/flow bubble' do
          fail
        end
        # TODO: Object heirachy collision checks
      end
    end
  end
end
# rubocop:enable all

# puts "TEST:     FOOBEFORE!FOOBAR!SOMETHING!FUBAR!DONE"
# puts "RESPONSE: #{Foo.new.test}"