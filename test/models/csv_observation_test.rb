require 'test_helper'

class CsvObservationTest < ActiveSupport::TestCase

  test 'csvobservation handles assignment correctly' do
    assert_raise ActiveModel::UnknownAttributeError do
      csvobservation = CsvObservation.new({ 'foo' => 'bar'})
    end
    assert_raise NameError do
      csvobservation.foo
    end

    #assert_includes csvobservation.errors.full_messages, "Unknown field: 'FOO'"

  end

end
