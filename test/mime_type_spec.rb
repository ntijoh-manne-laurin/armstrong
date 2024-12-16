# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/mime_types'

describe 'mime_types' do
  it 'works for jpg' do
    file = 'test.jpg'
    _(get_mime_from_file_name(file)).must_equal 'image/jpeg'
  end
  it 'works for jpeg' do
    file = 'test.jpeg'
    _(get_mime_from_file_name(file)).must_equal 'image/jpeg'
  end
  it 'works for .ico' do
    file = 'test.ico'
    _(get_mime_from_file_name(file)).must_equal 'image/vnd.microsoft.icon'
  end
end

