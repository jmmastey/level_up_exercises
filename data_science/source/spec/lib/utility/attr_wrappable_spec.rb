require_relative '../../spec_helper.rb'

module Utility
  # rubocop:disable all
  module Mocks
    class Foo
      include ::Utility::Wrappable

      attr_wrappable :foo do |*args|
        "-#{super(*args)}-"
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
  # rubocop:enable all

  describe Wrappable do
    context 'after included' do
      it 'exposes attr_wrappable' do
        expect(Mocks::Foo).to respond_to(:attr_wrappable)
      end
      context 'attr_wrappable' do
        foo = Mocks::Foo.new
        it 'prepends the hook' do
          expected = Utility::Wrappable::Hook
          expect(foo.class.ancestors.first).to eq(expected)
        end
        it 'exposes the wrappables accessor' do
          expect(foo).to respond_to(:wrappables)
        end
        it 'records wrapped methods in @wrappables' do
          wrappables = foo.wrappables
          expect(wrappables.keys).to include(:foo, :bar)
        end
        it 'wraps a method' do
          expected = '!FOOBAR!TESTING!FUBAR!'
          expect(foo.bar('TESTING')).to eq(expected)
        end
        it 'wraps multiple methods' do
          expected = '-FOOBEFORE!FOOBAR!SOMETHING!FUBAR!DONE-'
          expect(foo.test).to eq(expected)
        end
        # TODO: Object heirachy collision checks
      end
    end
  end
end
