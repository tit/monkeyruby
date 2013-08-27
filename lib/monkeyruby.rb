# encoding: utf-8

# Wrapper class for monkeyrunner test framework
#
# @example
#   monkeyruby = Monkeyruby.new 'example.py', 'com.component.name'
#   monkeyruby.touch 640, 480
#   monkeyruby.wait
#   monkeyruby.type 'foo'
#   monkeyruby.drug 320, 200, 640, 480
class Monkeyruby
  # @param [String] filename
  # @param [String] component
  # @return [TrueClass]
  def initialize(filename, component)
    @file = File.open filename, 'w+'
    @file.write "# coding=utf-8\n"
    @file.write "# noinspection PyUnresolvedReferences\n"
    @file.write "from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice\n"
    @file.write "device = MonkeyRunner.waitForConnection()\n"
    @file.write "device.startActivity(component='#{component}')\n"
    self.wait 5
    true
  end

  # @param [Fixnum] x
  # @param [Fixnum] y
  # @param [String] type
  # @return [TrueClass]
  def touch(x, y, type = 'MonkeyDevice.DOWN_AND_UP')
    @file.write "device.touch(#{x}, #{y}, #{type})\n"
    true
  end

  # @param [Fixnum] seconds
  # @return [TrueClass]
  def wait(seconds = 1)
    @file.write "MonkeyRunner.sleep(#{seconds})\n"
    true
  end

  # @param [String] text
  # @return [TrueClass]
  def type(text)
    @file.write "device.type(#{text})\n"
    true
  end

  # @param [Fixnum] start_x
  # @param [Fixnum] start_y
  # @param [Fixnum] stop_x
  # @param [Fixnum] stop_y
  # @param [Fixnum] duration
  # @param [Fixnum] steps
  # @return [TrueClass]
  def drug(start_x, start_y, stop_x, stop_y, duration = 1, steps = 10)
    @file.write "device.drag(tuple([#{start_x}, #{start_y}]), tuple([#{stop_x}, #{stop_y}]), #{duration}, #{steps})\n"
    true
  end
end